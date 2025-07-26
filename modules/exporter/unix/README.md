# Unix Module

Handles scraping Node Exporter metrics.

## Components

- [`local`](#local)
- [`scrape`](#scrape)

### `local`

#### Arguments

| Name                 | Optional | Default                       | Description                                |
| :------------------- | :------- | :---------------------------- | :----------------------------------------- |
| `enable_collectors`  | `true`   | [see code](metrics.alloy#L19) | A list of collectors to enable             |
| `disable_collectors` | `true`   | [see code](metrics.alloy#L20) | A list of collectors to disable            |
| `namespace_label`    | `true`   | `node`                        | The namespace label to add for all metrics |

#### Exports

| Name     | Type                | Descriptions               |
| :------- | :------------------ | :------------------------- |
| `output` | `list(map(string))` | List of discovered targets |

#### Labels

The following labels are automatically added to exported targets.

| Label       | Description                           |
| :---------- | :------------------------------------ |
| `namespace` | Set to the value of `namespace_label` |

---

### `scrape`

#### Arguments

| Name              | Optional | Default                       | Description                                              |
| :---------------- | :------- | :---------------------------- | :------------------------------------------------------- |
| `targets`         | `false`  | `list(map(string))`           | A list of targets to scrape                              |
| `forward_to`      | `false`  | `list(MetricsReceiver)`       | A list of where collected metrics should be forwarded to |
| `job_label`       | `true`   | `integrations/alloy`          | The job label to add for all metrics                     |
| `keep_metrics`    | `true`   | [see code](metrics.alloy#L92) | A regular expression of metrics to keep                  |
| `drop_metrics`    | `true`   | [see code](metrics.alloy#L85) | A regular expression of metrics to drop                  |
| `scrape_interval` | `true`   | `60s`                         | How often to scrape metrics from the targets             |
| `scrape_timeout`  | `true`   | `10s`                         | How long before a scrape times out                       |

#### Labels

The following labels are automatically added to exported targets.

| Label | Description                     |
| :---- | :------------------------------ |
| job   | Set to the value of `job_label` |

---

## Usage

### `local`

The following example will scrape node exporter metrics on the local machine.

```alloy
import.git "unix_metrics" {
  repository = "https://github.com/lavery98/alloy-modules.git"
  revision = "main"
  path = "modules/exporter/unix/metrics.alloy"
  pull_frequency = "15m"
}

// Get the targets
unix_metrics.local "targets" {}

// Get the metrics
unix_metrics.scrape "metrics" {
    targets = unix_metrics.local.targets.output
    forward_to = [
        prometheus.remote_write.default.receiver,
    ]
    scrape_interval = "15s"
}

// write the metrics
prometheus.remote_write "default" {
  endpoint {
    url = "http://mimir:9009/api/v1/push"

    basic_auth {
      username = "example-user"
      password = "example-password"
    }
  }
}
```
