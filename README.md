# dotfiles

Work in progress. The settings are on the `wip` branch; `main` does not yet contain them. Review each configuration before using it on a machine.

## Link the settings

Run `bash deploy.sh` to preview the links and backups. Run `bash deploy.sh --apply` to apply them. The script locates its own checkout, creates `~/.config` when needed, backs up a conflicting file or directory beside its original path as `.backup.YYYYMMDD-HHMMSS`, and skips links that already point to the checkout. It links macOS (`skhd`, `yabai`) or Linux (`hypr`) settings according to the current OS. Restore a backup by removing the link and moving the backup back to its original path.

The checked-in `spotifyd/spotifyd.conf` is linked to `~/.config/spotifyd/spotifyd.conf`; OAuth credentials live in Spotifyd’s cache outside this public repository. `.gitconfig.local` is local to each machine. Starship’s file is linked to `~/.config/starship.toml`.

The current `.zshrc` still refers to `~/dotfiles` internally. Linking from another checkout works, but shell initialization from that checkout needs the separate path fix in issue #5 before use. Neovim and other configurations also need validation on the target machine; do not treat this preview as a full installation check.

Run `bash tests/deploy-test.sh` for an isolated deploy smoke test. It does not change the real home directory.

## Spotifyd

After applying the links, run `spotifyd authenticate`, then check playback with `spotifyd --no-daemon`. Spotifyd 0.4+ uses OAuth; do not add a username, password, or credential file to this repository. The config leaves `cache_path` unset so Spotifyd chooses its default location. If the default audio backend does not suit the machine, select one with Spotifyd’s `--backend` option.

An existing `~/.config/spotifyd` directory is backed up by `deploy.sh --apply`. The old `~/.spotifyd.conf`, if present from a previous setup, is left untouched; inspect it and remove it yourself after confirming the new configuration. Reauthenticate if the old setup used a different cache path.
