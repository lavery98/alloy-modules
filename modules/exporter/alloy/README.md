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

---

### `scrape`
