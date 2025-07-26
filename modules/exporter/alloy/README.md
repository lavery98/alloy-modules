# Alloy Module

Handles scraping Grafana Alloy metrics.

## Components

- [`local`](#local)
- [`scrape`](#scrape)

### `local`

#### Arguments

| Name              | Optional | Default | Description                                |
| :---------------- | :------- | :------ | :----------------------------------------- |
| `namespace_label` | `true`   | `node`  | The namespace label to add for all metrics |

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
| `keep_metrics`    | `true`   | [see code](metrics.alloy#L65) | A regular expression of metrics to keep                  |
| `drop_metrics`    | `true`   | [see code](metrics.alloy#L71) | A regular expression of metrics to drop                  |
| `scrape_interval` | `true`   | `60s`                         | How often to scrape metrics from the targets             |
| `scrape_timeout`  | `true`   | `10s`                         | How long before a scrape times out                       |

#### Labels

The following labels are automatically added to exported targets.

| Label | Description                     |
| :---- | :------------------------------ |
| job   | Set to the value of `job_label` |
