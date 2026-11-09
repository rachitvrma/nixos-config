set shell := ["bash", "-euo", "pipefail", "-c"]

host := "nixpavilion"
stow := env("STOW", "stow")

# Plain `just` builds the system without switching.
default:
  @just --list

# --- dotfiles ---------------------------------------------------------------

# just install            all packages
# just install fish git   specific packages
# Conflicting files are moved to *.pre-stow first.
install *pkgs:
    ./scripts/backup-conflicts.sh {{ pkgs }}
    {{ stow }} {{ if pkgs == "" { `ls dotfiles | xargs` } else { pkgs } }}
    @for d in ~/.gnupg ~/.ssh; do [ -d "$d" ] && chmod 700 "$d" || true; done
    @echo "===Dotfiles Installed==="

# Simulate only: no backups, nothing modified. Conflicts show up as errors.
dry *pkgs:
    stow -nv {{ if pkgs == "" { `ls dotfiles | xargs` } else { pkgs } }}

uninstall *pkgs:
    {{ stow }} -D {{ if pkgs == "" { `ls dotfiles | xargs` } else { pkgs } }}

# --- NixOS ------------------------------------------------------------------

# Evaluate and build the system without switching.
build:
    nh os build . -H {{ host }}

switch:
    nh os switch . -H {{ host }}

# Every flake output, evaluated (catches option typos before a switch).
check:
    nix flake check --no-build

# Inputs are pinned by tack (.tack/pins.toml), not by a flake.lock.
update:
    tack update

fmt:
    nix fmt

# Install onto a blank disk: partitions, encrypts, creates the swapfile.
# DESTROYS /dev/nvme0n1. Run from the NixOS installer.
nixos-install:
    sudo nix run github:nix-community/disko -- --mode destroy,format,mount --flake .#{{ host }}
    sudo nixos-install --flake .#{{ host }}

# Only needed if hibernation does not resume (see _hibernation.nix).
resume-offset:
    ./scripts/nixos/resume-offset.sh
