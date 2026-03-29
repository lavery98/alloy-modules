# Module Components

Modules related to Alloy integrations.

## Components

- [`components_alloy`](#components_alloy)
- [`components_cadvisor`](#components_cadvisor)
- [`components_node_exporter`](#components_node_exporter)
- [`components_postgres`](#components_postgres)

### `components_alloy`

#### Arguments

| Name              | Optional | Default                  | Description                                              |
| :---------------- | :------- | :----------------------- | :------------------------------------------------------- |
| `forward_to`      | `false`  | `list(MetricsReceiver)`  | A list of where collected metrics should be forwarded to |
| `namespace_label` | `true`   | `node`                   | The namespace label to add for all metrics               |
| `job_label`       | `true`   | `integrations/alloy`     | The job label to add for all metrics                     |
| `instance_name`   | `true`   | `system hostname`        | The instance name to add for all metrics                 |
| `keep_metrics`    | `true`   | `(^(go\|process)\_.\*$)` | A regular expression of metrics to keep                  |
| `drop_metrics`    | `true`   | `(.*)`                   | A regular expression of metrics to drop                  |
| `scrape_interval` | `true`   | `60s`                    | How often to scrape metrics from the targets             |
| `scrape_timeout`  | `true`   | `10s`                    | How long before a scrape times out                       |

#### Exports

This component has no exports.

#### Example

```alloy
import.git "integrations_alloy" {
  repository     = "https://github.com/lavery98/alloy-modules.git"
  revision       = "main"
  path           = "modules/integrations/alloy.alloy"
  pull_frequency = "15m"
}

integrations_alloy.components_alloy "default" {
  forward_to = [
    provider.self_hosted.default.metrics_receiver,
  ]
  scrape_interval = "15s"
}
```

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

### `components_node_exporter`

#### Arguments

| Name                 | Optional | Default                                                       | Description                                              |
| :------------------- | :------- | :------------------------------------------------------------ | :------------------------------------------------------- |
| `forward_to`         | `false`  | `list(MetricsReceiver)`                                       | A list of where collected metrics should be forwarded to |
| `namespace_label`    | `true`   | `node`                                                        | The namespace label to add for all metrics               |
| `job_label`          | `true`   | `integrations/node_exporter`                                  | The job label to add for all metrics                     |
| `instance_name`      | `true`   | `system hostname`                                             | The instance name to add for all metrics                 |
| `enable_collectors`  | `true`   | `["logind", "mountstats", "processes", "systemd", "tcpstat"]` | A list of collectors to enable                           |
| `disable_collectors` | `true`   | `["mdadm"]`                                                   | A list of collectors to disable                          |
| `keep_metrics`       | `true`   | `(^(go)_.*$)`                                                 | A regular expression of metrics to keep                  |
| `drop_metrics`       | `true`   | `(.*)`                                                        | A regular expression of metrics to drop                  |
| `scrape_interval`    | `true`   | `60s`                                                         | How often to scrape metrics from the targets             |
| `scrape_timeout`     | `true`   | `10s`                                                         | How long before a scrape times out                       |

#### Exports

This component has no exports.

#### Example

```alloy
import.git "integrations_node_exporter" {
  repository     = "https://github.com/lavery98/alloy-modules.git"
  revision       = "main"
  path           = "modules/integrations/node-exporter.alloy"
  pull_frequency = "15m"
}

integrations_node_exporter.components_node_exporter "default" {
  forward_to = [
    provider.self_hosted.default.metrics_receiver,
  ]
  scrape_interval = "15s"
}
```

### `components_postgres`

#### Arguments

| Name                     | Optional | Default                 | Description                                                                                                  |
| :----------------------- | :------- | :---------------------- | :----------------------------------------------------------------------------------------------------------- |
| `forward_to`             | `false`  | `list(MetricsReceiver)` | A list of where collected metrics should be forwarded to                                                     |
| `data_source_names`      | `false`  | `list(string)`          | A list of PostgreSQL connection strings (e.g. `postgresql://user:password@host:5432/dbname?sslmode=disable`) |
| `namespace_label`        | `true`   | `node`                  | The namespace label to add for all metrics                                                                   |
| `job_label`              | `true`   | `integrations/postgres` | The job label to add for all metrics                                                                         |
| `instance_name`          | `true`   | `system hostname`       | The instance name to add for all metrics                                                                     |
| `autodiscover_databases` | `true`   | `false`                 | Whether to automatically discover and scrape all databases                                                   |
| `keep_metrics`           | `true`   | `(.*)`                  | A regular expression of metrics to keep                                                                      |
| `drop_metrics`           | `true`   | `""`                    | A regular expression of metrics to drop                                                                      |
| `scrape_interval`        | `true`   | `60s`                   | How often to scrape metrics from the targets                                                                 |
| `scrape_timeout`         | `true`   | `10s`                   | How long before a scrape times out                                                                           |

#### Exports

This component has no exports.

#### Example

```alloy
import.git "integrations_postgres" {
  repository     = "https://github.com/lavery98/alloy-modules.git"
  revision       = "main"
  path           = "modules/integrations/postgres.alloy"
  pull_frequency = "15m"
}

integrations_postgres.components_postgres "default" {
  forward_to = [
    provider.self_hosted.default.metrics_receiver,
  ]
  data_source_names = ["postgresql://user:password@host:5432/dbname?sslmode=disable"]
  scrape_interval   = "15s"
}
```
