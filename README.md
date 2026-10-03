# Random Theme

Bar widget for [Omarchy](https://omarchy.org) that applies a random theme on every click.

- **Left click**: apply a random theme (never repeats the active one)
- **Hover**: shows `Active theme: <name>`
- **Toast**: after applying, a notification shows **\<theme\>** `applied.`

## Install

```sh
omarchy plugin add https://github.com/claudiuIosif/omarchy-random-theme.git --enable
```

## External dependencies

- `omarchy` CLI (`theme list`, `theme set`, `theme current`) — ships with Omarchy
- `omarchy-notification-send` — ships with Omarchy
- `bash`

No daemons, no background work. The helper script runs once per click.
