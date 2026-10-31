# MailHog Homebrew tap

Install the MailHog fork maintained at [OseimuohanI/MailHog](https://github.com/OseimuohanI/MailHog).

## Install

```sh
brew install OseimuohanI/mailhog/mailhog
```

## Upgrade

```sh
brew update
brew upgrade OseimuohanI/mailhog/mailhog
```

If MailHog is already running as a service, restart it after upgrading:

```sh
brew services restart OseimuohanI/mailhog/mailhog
```

## Run

```sh
mailhog
```

- SMTP: `localhost:1025`
- Web interface: http://localhost:8025
- Messages: `~/MailHog/mailhog-data`
- Settings, labels, and Jim state: `~/MailHog/mailhog-state`

To start it as a background service:

```sh
brew services start OseimuohanI/mailhog/mailhog
```

Version 2.1.0 includes the minimal inbox and reader, five themes, projects and tags,
protected cleanup, repeatable SMTP scenarios, assertion and extraction APIs,
content/link checks, and device previews with version comparisons. Cleanup is
opt-in. Themes are in Settings; testing tools are in the header.

See the [workbench guide](https://github.com/OseimuohanI/MailHog/blob/v2.1.0/docs/WORKBENCH.md)
and [release notes](https://github.com/OseimuohanI/MailHog/releases/tag/v2.1.0).

## Build from source

Requires Go 1.25 or newer:

```sh
git clone https://github.com/OseimuohanI/MailHog.git
cd MailHog
go build -mod=vendor -o MailHog .
./MailHog
```

## License

[MIT](https://github.com/OseimuohanI/MailHog/blob/main/LICENSE.md).
