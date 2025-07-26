# Journal Module

Handles reading journal logs.

## Components

- [`local`](#local)

### `local`

### Arguments

| Name              | Optional | Default                 | Description                                           |
| :---------------- | :------- | :---------------------- | :---------------------------------------------------- |
| `forward_to`      | `false`  | `list(MetricsReceiver)` | A list of where collected logs should be forwarded to |
| `namespace_label` | `true`   | `node`                  | The namespace label to add for all logs               |
| `job_label`       | `true`   | `node/journal`          | The job label to add for all logs                     |

---

## Usage

### `local`

The following example will read journal logs on the local machine.

```alloy
import.git "journal_logs" {
  repository = "https://github.com/lavery98/alloy-modules.git"
  revision = "main"
  path = "modules/system/journal/logs.alloy"
  pull_frequency = "15m"
}

journal_logs.local "read" {
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
