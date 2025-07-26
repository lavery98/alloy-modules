# Alloy Modules

[Modules](https://grafana.com/docs/alloy/latest/concepts/modules/) are a way to create Grafana [Alloy](https://grafana.com/docs/alloy/latest/) configurations which can be loaded as a component. This repository contains modules that I use across my various Alloy instances.

## Referencing Modules

Whenever a pull request is merged to the `main` branch, a tag is automatically created and published, by default this is a patch bump.

Modules can be referenced directly from this git repository using the `import.git` component. It is recommended to always reference a tagged version, and not the `main` branch.
