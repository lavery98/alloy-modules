# Module Components

Modules related to Alloy integrations.

## Components

- [`components_cadvisor`](#components_cadvisor)

### `components_cadvisor`

#### Arguments

| Name              | Optional | Default                 | Description                                              |
| :---------------- | :------- | :---------------------- | :------------------------------------------------------- |
| `forward_to`      | `false`  | `list(MetricsReceiver)` | A list of where collected metrics should be forwarded to |
| `namespace_label` | `true`   | `node`                  | The namespace label to add for all metrics               |
| `job_label`       | `true`   | `integrations/cadvisor` | The job label to add for all metrics                     |
| `instance_name`   | `true`   | `system hostname`       | The instance name to add for all metrics                 |
| `scrape_interval` | `true`   | `60s`                   | How often to scrape metrics from the targets             |
| `scrape_timeout`  | `true`   | `10s`                   | How long before a scrape times out                       |

#### Exports

This component has no exports.

#### Example

```alloy
import.git "integrations_cadvisor" {
  repository     = "https://github.com/lavery98/alloy-modules.git"
  revision       = "main"
  path           = "modules/integrations/cadvisor.alloy"
  pull_frequency = "15m"
}

integrations_cadvisor.components_cadvisor "default" {
  forward_to = [
    provider.self_hosted.default.metrics_receiver,
  ]
  scrape_interval = "15s"
}
```
