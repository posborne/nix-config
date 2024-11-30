default:
	@just --list

check:
	nix flake check --impure --keep-going

rebuild-pre:
	git add *.nix

rebuild-nixos: rebuild-pre
	sudo nixos-rebuild switch --flake .

update-home: rebuild-pre
	home-manager update --flake .#posborne@qemu-vm

rebuild-home: rebuild-pre
	home-manager switch --flake .#posborne@qemu-vm

rebuild-all: rebuild-nixos rebuild-home

update:
	nix flake update

diff:
	git diff ':!flake.lock'
