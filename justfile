default:
	@just --list

check:
	nix flake check --impure --keep-going

rebuild-pre:
	git add *.nix

rebuild-nixos: rebuild-pre
	sudo nixos-rebuild switch --flake .

rebuild-home: rebuild-pre
	home-manager switch --flake .#posborne@fedora

rebuild-all: rebuild-nixos rebuild-home

update:
	nix flake update

diff:
	git diff ':!flake.lock'
