# Docker Module

Handles scraping metrics and reading logs from Docker.

**Modules:**

- [`logs.alloy`](#logsalloy)
- [`metrics.alloy`](#metricsalloy)

## `logs.alloy`

**Components**

- [`local`](#local)

### `local`

#### Arguments

| Name         | Optional | Default                 | Description                                           |
| :----------- | :------- | :---------------------- | :---------------------------------------------------- |
| `targets`    | `false`  | `list(map(string))`     | A list of targets to read logs from                   |
| `forward_to` | `false`  | `list(MetricsReceiver)` | A list of where collected logs should be forwarded to |

### Usage

```alloy
import.git "docker_logs" {
  repository = "https://github.com/lavery98/alloy-modules.git"
  revision = "main"
  path = "modules/system/docker/logs.alloy"
  pull_frequency = "15m"
}

discovery.docker "containers" {
  host = "unix:///var/run/docker.sock"
}

docker_logs.local "read" {
  targets = discovery.docker.containers.targets
  forward_to = [loki.write.default.receiver]
}

loki.write "default" {
  endpoint {
    url = "https://loki:3100/loki/api/v1/push"

    basic_auth {
      username = "example-user"
      password = "example-password"
    }
  }
}
```

---

## `metrics.alloy`

**Components**

- [`local`](#local-1)
- [`scrape`](#scrape)

### `local`

#### Arguments

| Name            | Optional | Default               | Description                                       |
| :-------------- | :------- | :-------------------- | :------------------------------------------------ |
| `label_filters` | `true`   | `[]`                  | The label filters to use to find matching targets |
| `label_prefix`  | `true`   | `com.grafana.metrics` | The prefix for the scrape labels to use           |

#### Exports

| Name     | Type                | Descriptions               |
| :------- | :------------------ | :------------------------- |
| `output` | `list(map(string))` | List of discovered targets |

### `scrape`

#### Arguments

| Name              | Optional | Default                       | Description                                              |
| :---------------- | :------- | :---------------------------- | :------------------------------------------------------- |
| `targets`         | `false`  | `list(map(string))`           | A list of targets to scrape                              |
| `forward_to`      | `false`  | `list(MetricsReceiver)`       | A list of where collected metrics should be forwarded to |
| `keep_metrics`    | `true`   | [see code](metrics.alloy#L146) | A regular expression of metrics to keep                  |
| `drop_metrics`    | `true`   | [see code](metrics.alloy#L139) | A regular expression of metrics to drop                  |
| `bearer_token`    | `true`   | `none`                        | Bearer token for authentication                          |
| `scrape_interval` | `true`   | `60s`                         | How often to scrape metrics from the targets             |
| `scrape_timeout`  | `true`   | `10s`                         | How long before a scrape times out                       |

### Usage

```alloy
import.git "docker_metrics" {
  repository = "https://github.com/lavery98/alloy-modules.git"
  revision = "main"
  path = "modules/system/docker/metrics.alloy"
  pull_frequency = "15m"
}

// Get the target containers
docker_metrics.discover "containers" {
}

// Get the metrics
docker_metrics.scrape "scrape" {
  targets = docker_metrics.discover.containers.output
  forward_to = [prometheus.remote_write.default.receiver]
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
