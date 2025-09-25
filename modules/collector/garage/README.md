# Garage Module

Handles scraping [Garage](https://garagehq.deuxfleurs.fr/) metrics.

## Components

- [`local`](#local)
- [`scrape`](#scrape)

### `local`

**_Arguments_**

| Name              | Required | Default       | Description                                |
| :---------------- | :------- | :------------ | :----------------------------------------- |
| `port`            | _no_     | `3903`        | The port to scrape metrics from.           |
| `namespace_label` | _no_     | `node`        | The namespace label to add for all metrics |
| `job_label`       | _no_     | `node/garage` | The job label to add for all metrics       |

**_Exports_**

| Name     | Type                | Description                |
| :------- | :------------------ | :------------------------- |
| `output` | `list(map(string))` | List of discovered targets |

### `scrape`

**_Arguments_**

| Name              | Required | Default                       | Description                                                                |
| :---------------- | :------- | :---------------------------- | :------------------------------------------------------------------------- |
| `targets`         | _yes_    | `N/A`                         | A list of targets to scrape                                                |
| `forward_to`      | _yes_    | `N/A`                         | A list of `MetricsReceiver` where collected metrics should be forwarded to |
| `keep_metrics`    | _no_     | [see code](metrics.alloy#L88) | A regular expression of metrics to keep                                    |
| `drop_metrics`    | _no_     | [see code](metrics.alloy#L81) | A regular expression of metrics to drop                                    |
| `bearer_token`    | _no_     | `none`                        | Bearer token for authentication                                            |
| `scrape_interval` | _no_     | `60s`                         | How often to scrape metrics from the targets                               |
| `scrape_timeout`  | _no_     | `10s`                         | How long before a scrape times out                                         |

## Usage

The following example will scrape Garage metrics on the local machine.

```alloy
import.git "garage_metrics" {
  repository = "https://github.com/lavery98/alloy-modules.git"
  revision = "main"
  path = "modules/collector/garage/metrics.alloy"
  pull_frequency = "15m"
}

// Get the targets
garage_metrics.local "targets" {}

// Get the metrics
garage_metrics.scrape "metrics" {
    targets = garage_metrics.local.targets.output
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
