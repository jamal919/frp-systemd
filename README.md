## frp-systemd : A systemd unit for frp (fast reverse proxy)

[frp](https://github.com/fatedier/frp) is a reverse proxy client-server software, similar to [ngrok](https://ngrok.com), except self-hosted and no limit! This repository contains script to install and uninstall frp, and create systemd unit for auto management of the services. Systemd services are currently installed as system service, so that they are available as system-wide services.

## Installation
1. Clone this repository to the target machine `git clone https://github.com/jamal919/systemd`.
2. Update the `frpc.toml` for the client machine, or `frps.toml` for the server machine. See the [frp readme](https://github.com/fatedier/frp?tab=readme-ov-file#readme) for details.
3. Run `install.sh`. If needed make it executable with `chmod +x install.sh`.
3. To enable auto-restart of the service `sudo systemctl enable <name>.service` where `<name>` is one of `frps` for server or `frpc` for the client.
4. To start the service now `sudo systemctl start <name>.service` where `<name>` is replaced as in 3.

## Uninstall
Run `uninstall.sh` as root or sudo. If needed make it executable with `chmod +x uninstall.sh`

## Acknowledgement
The excellent work of [frp](https://github.com/fatedier/frp) devs.
