# Repository Guidelines

## Project Structure & Module Organization
- `nephilims/` — Host profiles (e.g., `vergil`, `dante`), plus `installer.nix` and hardware/optimization files.
- `devil-arms/` — NixOS modules (e.g., `apps.nix`, `networking.nix`, `security.nix`); aggregated in `devil-arms/default.nix`.
- `devil-breakers/` — Home Manager modules (`programs/`, `shell/`, `desktop/`, `slayer/`); aggregated in `devil-breakers/default.nix`.
- `devil-triggers/` — Enhancements, themes, and small utilities (see `nico/`, `theme/`).
- `orbs/` — Nix overlays (e.g., `font-dankmono/`, `keyd.nix`).
- `morrison/` — Documentation and troubleshooting notes.
- `sins/` — Age/Agenix-managed encrypted secrets (`*.age`). Never store plaintext here.

## Build, Test, and Development Commands
- Enter dev shell: `nix develop` (provides `nil`, `statix`, `nixfmt-rfc-style`, docs via `manix`).
- Format: `nix fmt` (flake formatter: `nixpkgs-fmt`). Run before committing.
- Lint: `statix check` (auto-fix: `statix fix`).
- Evaluate a host: `nix eval .#nixosConfigurations.vergil.config.system.build.toplevel.drvPath`.
- Build a host: `nix build .#nixosConfigurations.vergil.config.system.build.toplevel`.
- Switch on target host: `sudo nixos-rebuild switch --flake .#vergil`.
- Build installer ISO (example): `nix build .#nixosConfigurations.vergilInstaller.config.system.build.isoImage -o vergil-iso`.

## Coding Style & Naming Conventions
- Nix files: two-space indent; one attribute per line; keep modules small and composable.
- Filenames: lowercase, hyphen-separated; entry points named `default.nix`.
- Keep host-specific logic in `nephilims/<host>/`; shareable logic belongs in `devil-arms/` or `devil-breakers/`.
- Prefer explicit imports; when adding a module, list it in the corresponding `default.nix` aggregator.

## Testing Guidelines
- Quick checks: `nix fmt && statix check`.
- Evaluation: build toplevel for each changed host; for cautious rollouts use `nixos-rebuild test --flake .#<host>`.
- No separate unit tests; validation is by evaluation/build and manual verification of affected services.

## Commit & Pull Request Guidelines
- Commits: short, imperative, and scoped. Examples: `vergil: enable bluetooth`, `devil-breakers/nvim: update keymaps`.
- PRs: include purpose, hosts impacted, sample build command, and screenshots for visual changes (e.g., wallpapers/GTK tweaks).
- Required prechecks: `nix fmt`, `statix check`, and successful host evaluation/build for touched systems.

## Security & Configuration Tips
- Manage secrets with Agenix only (`sins/*.age`). Never commit decrypted material or private keys.
- If adding a new secret, document its use and reference path; verify the target host owns the decryption key.

## Agent-Specific Instructions
- Package installation: before adding any new package, use the `web.run` tool to look up the exact package/attribute name and current availability in the target channel (e.g., nixpkgs `nixos-unstable`). Do not rely on memory for names; it often fails. Confirm the attribute path (e.g., `pkgs.<attr>`) and any required overlays, then build/evaluate to verify.
