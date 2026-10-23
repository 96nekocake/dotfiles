# dotfiles

Work in progress. The settings are on the `wip` branch; `main` does not yet contain them. Review each configuration before using it on a machine.

## Link the settings

Run `bash deploy.sh` to preview the links and backups. Run `bash deploy.sh --apply` to apply them. The script locates its own checkout, creates `~/.config` when needed, backs up a conflicting file or directory beside its original path as `.backup.YYYYMMDD-HHMMSS`, and skips links that already point to the checkout. It links macOS (`skhd`, `yabai`) or Linux (`hypr`) settings according to the current OS. Restore a backup by removing the link and moving the backup back to its original path.

The checked-in `.spotifyd.conf` is an example and is deliberately not deployed. Keep credentials outside this public repository. `.gitconfig.local` is also local to each machine. Starship's file is linked to `~/.config/starship.toml`.

The current `.zshrc` still refers to `~/dotfiles` internally. Linking from another checkout works, but shell initialization from that checkout needs the separate path fix in issue #5 before use. Neovim and other configurations also need validation on the target machine; do not treat this preview as a full installation check.

Run `bash tests/deploy-test.sh` for an isolated deploy smoke test. It does not change the real home directory.
