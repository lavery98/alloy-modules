# Agent Guide: alloy-modules

This repository contains reusable [Grafana Alloy](https://grafana.com/docs/alloy/latest/) configuration modules for collecting metrics and logs. Modules are imported via `import.git` and versioned with Git tags.

## Repository Layout

```
modules/
  collector/       # Modules that scrape external services (garage, samba)
  integrations/    # Built-in Alloy integrations (alloy, cadvisor, node-exporter)
  provider/        # Backend delivery targets (self_hosted: Mimir/Loki/Tempo)
  system/          # System-level collection (docker, journal)
scripts/           # Lint and format shell scripts
.github/workflows/ # CI (lint) and auto-tag on merge
```

Each subdirectory under `modules/` contains `.alloy` files and a `README.md` documenting arguments, exports, and usage examples.

## Alloy Module Conventions

### File structure

Every `.alloy` file contains one or more `declare` blocks. Each block is a named, reusable component:

```alloy
declare "component_name" {
  argument "forward_to" {
    comment = "A list(MetricsReceiver) of where collected metrics should be forwarded to (required)"
  }

  argument "scrape_interval" {
    comment  = "How often to scrape metrics from the targets (default: 60s)"
    optional = true
    default  = "60s"
  }

  prometheus.scrape "label" { ... }

  export "output" {
    value = some_component.output
  }
}
```

### Argument conventions

- Required arguments: omit `optional` and `default`.
- Optional arguments: set `optional = true`. If there is a meaningful default, set `default =` as well.
- Use `coalesce(argument.foo.value, "fallback")` when you need a runtime fallback for an optional argument that has no static `default`.
- The `comment` field documents both the type and the default, e.g. `"A list(MetricsReceiver) of where collected metrics should be forwarded to (required)"`.

### Standard pipeline pattern (metrics)

```
discover → discovery.relabel → prometheus.scrape → prometheus.relabel → forward_to
```

- `discovery.relabel` sets `namespace`, `job`, `instance`, `container`, `source` labels before scraping.
- `prometheus.relabel` applies `drop_metrics` and `keep_metrics` regex filters after scraping.
- Always wire through `[prometheus.relabel.<name>.receiver]`, not directly to `forward_to`.

### Metric filtering

```alloy
// Drop first, then keep
rule {
  action        = "drop"
  regex         = coalesce(argument.drop_metrics.value, "")
  source_labels = ["__name__"]
}
rule {
  action        = "keep"
  regex         = coalesce(argument.keep_metrics.value, "(.*)")
  source_labels = ["__name__"]
}
```

### Internal component naming

Use the pattern `<component_type>.<module_context>` for internal block labels, e.g.:
- `prometheus.scrape "integrations_alloy"`
- `discovery.relabel "docker_metrics"`

This keeps Alloy's internal debug UI readable.

### Formatting

- `.alloy` files: **tabs** for indentation (enforced by `alloy fmt` and `.editorconfig`).
- All other files: **2-space** indentation.
- UTF-8, LF line endings, trailing newline required on all files.

## README Conventions

Each module directory needs a `README.md` with:

1. Short description paragraph.
2. **Components** list (one bullet per `declare` block, linking to its section).
3. Per-component sections containing:
   - **Arguments** table: `Name | Optional | Default | Description`
   - **Exports** table (if any): `Name | Type | Description`
4. **Usage** section with a working `import.git` + instantiation example.

Column alignment in tables must pass `markdownlint-cli2` and `prettier`.

## Tooling

| Command | Purpose |
| :--- | :--- |
| `make install` | Install Node dev dependencies via pnpm |
| `make lint` | Run all three linters (alloy, editorconfig, markdown) |
| `make lint-alloy` | Validate and format-check `.alloy` files |
| `make lint-editorconfig` | Check charset/indent/line-ending rules |
| `make lint-markdown` | Lint and format-check Markdown |
| `make format` | Auto-format Markdown with prettier |

Always run `make lint` before marking a task complete. The CI pipeline runs the same checks on every push and PR.

## Adding a New Module

1. Create a directory under the appropriate category (`collector/`, `integrations/`, `system/`, or `provider/`).
2. Write the `.alloy` file(s) following the conventions above.
3. Write a `README.md` following the documentation conventions above.
4. Update the parent category `README.md` to list the new module.
5. Run `make lint` and fix any issues before committing.

## Versioning

Tags are created automatically when a PR that modifies `.alloy` files is merged to `main` (patch bump by default, starting from `v0.1.0`). Always reference a specific tag, not `main`, in `import.git` blocks:

```alloy
import.git "module_name" {
  repository     = "https://github.com/lavery98/alloy-modules.git"
  revision       = "v0.1.5"
  path           = "modules/system/docker/metrics.alloy"
  pull_frequency = "15m"
}
```
