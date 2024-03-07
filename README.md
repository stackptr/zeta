# rc

System configuration flake for NixOS / [nix-darwin][nix-darwin-repo] hosts:

- 🌿 [`Rhizome`](./hosts/Rhizome/default.nix): personal laptop / 14-inch MacBook Pro
- 🌧️ [`Petrichor`](./hosts/Petrichor/default.nix): workstation / 16-inch MacBook Pro
- 🌀 [`zeta`](./hosts/zeta/default.nix): ARM server / Raspberry Pi 4 Model B
- ⚡️ [`ohm`](./hosts/ohm/default.nix): DigitalOcean virtual machine
- 🧿 [`nazar`](./hosts/nazar/default.nix): Dedicated Xeon E3-1270 server

<details>

<summary>Command reference</summary>

On a Linux-based system:

```shell
sudo nixos-rebuild switch --flake github:stackptr/rc
```

On a macOS system (note that `darwin-rebuild` will invoke `sudo` during activation):

```shell
darwin-rebuild switch --flake github:stackptr/rc
```

</details>

[nix-darwin-repo]: https://github.com/LnL7/nix-darwin
