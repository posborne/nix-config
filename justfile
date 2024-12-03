default_home_target := x".#${USERNAME}@${HOSTNAME:-qemu-vm}"
default_nixos_target := x".#${HOSTNAME}"

default:
    @just --list

check:
    nix flake check --impure --keep-going

rebuild-pre:
    # normally wouldn't do this, but fine for how we use this
    git add .

rebuild-nixos target=default_nixos_target: rebuild-pre
    sudo nixos-rebuild switch --flake {{ target }}

rebuild-home target=default_home_target: rebuild-pre
    home-manager switch --flake {{ target }}

rebuild-all nixos_target=default_nixos_target home_target=default_home_target: (rebuild-nixos nixos_target) (rebuild-home home_target)

fmt-all:
    # do check pass first and then format
    find . -name '*.nix' -type f  -exec nixfmt '-c' '-v' {} ';'
    find . -name '*.nix' -type f  -exec nixfmt '-v' {} ';'

update:
    nix flake update

diff:
    git diff ':!flake.lock'
