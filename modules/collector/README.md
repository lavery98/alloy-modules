# Module Components

Modules related to collecting from external sources

## Components

- [`components_crowdsec`](#components_crowdsec)
- [`components_tailscale`](#components_tailscale)

### `components_crowdsec`

#### Arguments

| Name               | Optional | Default                 | Description                                              |
| :----------------- | :------- | :---------------------- | :------------------------------------------------------- |
| `forward_to`       | `false`  | `list(MetricsReceiver)` | A list of where collected metrics should be forwarded to |
| `crowdsec_address` | `true`   | `127.0.0.1:6060`        | The address where the CrowdSec exporter is running       |
| `namespace_label`  | `true`   | `node`                  | The namespace label to add for all metrics               |
| `job_label`        | `true`   | `collectors/crowdsec`   | The job label to add for all metrics                     |
| `instance_name`    | `true`   | `system hostname`       | The instance name to add for all metrics                 |
| `keep_metrics`     | `true`   | `(.*)`                  | A regular expression of metrics to keep                  |
| `drop_metrics`     | `true`   | `""`                    | A regular expression of metrics to drop                  |
| `scrape_interval`  | `true`   | `60s`                   | How often to scrape metrics from the targets             |
| `scrape_timeout`   | `true`   | `10s`                   | How long before a scrape times out                       |

#### Exports

This component has no exports.

#### Example

```alloy
import.git "collector_crowdsec" {
  repository     = "https://github.com/lavery98/alloy-modules.git"
  revision       = "main"
  path           = "modules/collector/crowdsec.alloy"
  pull_frequency = "15m"
}

collector_crowdsec.components_crowdsec "default" {
  forward_to = [
    provider.self_hosted.default.metrics_receiver,
  ]
  scrape_interval = "15s"
}
```

### `components_tailscale`

#### Arguments

| Name                | Optional | Default                 | Description                                                 |
| :------------------ | :------- | :---------------------- | :---------------------------------------------------------- |
| `forward_to`        | `false`  | `list(MetricsReceiver)` | A list of where collected metrics should be forwarded to    |
| `tailscale_address` | `true`   | `100.100.100.100`       | The address where the Tailscale metrics endpoint is running |
| `namespace_label`   | `true`   | `node`                  | The namespace label to add for all metrics                  |
| `job_label`         | `true`   | `collectors/tailscale`  | The job label to add for all metrics                        |
| `instance_name`     | `true`   | `system hostname`       | The instance name to add for all metrics                    |
| `keep_metrics`      | `true`   | `(.*)`                  | A regular expression of metrics to keep                     |
| `drop_metrics`      | `true`   | `""`                    | A regular expression of metrics to drop                     |
| `scrape_interval`   | `true`   | `60s`                   | How often to scrape metrics from the targets                |
| `scrape_timeout`    | `true`   | `10s`                   | How long before a scrape times out                          |

#### Exports

This component has no exports.

#### Example

```alloy
import.git "collector_tailscale" {
  repository     = "https://github.com/lavery98/alloy-modules.git"
  revision       = "main"
  path           = "modules/collector/tailscale.alloy"
  pull_frequency = "15m"
}

collector_tailscale.components_tailscale "default" {
  forward_to = [
    provider.self_hosted.default.metrics_receiver,
  ]
  scrape_interval = "15s"
}
```
