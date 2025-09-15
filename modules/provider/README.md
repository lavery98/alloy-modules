# Provider Module

Handles sending metric, log and trace data to Mimir/Loki/Tempo.

## Components

- [`self_hosted`](#self_hosted)

### `self_hosted`

**_Arguments_**

| Name                   | Required | Default                             | Description                                     |
| :--------------------- | :------- | :---------------------------------- | :---------------------------------------------- |
| `metrics_endpoint_url` | _no_     | `http://mimir:8080/api/v1/push`     | Where to send collected metrics.                |
| `logs_endpoint_url`    | _no_     | `http://loki:3100/loki/api/v1/push` | Where to send collected logs.                   |
| `traces_endpoint_url`  | _no_     | `http://tempo:4318`                 | Where to send collected traces.                 |
| `external_labels`      | _no_     | `{}`                                | External labels to add to all metrics and logs. |

**_Exports_**

| Name               | Type                     | Description                                               |
| :----------------- | :----------------------- | :-------------------------------------------------------- |
| `metrics_receiver` | `prometheus.Interceptor` | A receiver that other components can send metric data to. |
| `logs_receiver`    | `loki.LogsReceiver`      | A receiver that other components can send log data to.    |
| `traces_receiver`  | `otelcol.Consumer`       | A receiver that other components can send trace data to.  |
