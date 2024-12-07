# posborne's Nix Configuration

This repo contains my personal nix configuraiton which can be applied
to a few different system configurations

1. NixOS: A full linux distribution managed entirely via Nix.
2. HomeManger: Used either with NixOS, on top of another linux
   distribution, or on top of Darwin.  The nix configuration
   for home-manager is where most packages are installed and
   configured for a single user.
3. Darwin: Contains MacOS specific configuration items.

## NixOS System Bootstrapping

At present, the steps for setting up a new NixOS machine require a few steps; in
time it may make sense to automate more of this using tools like
[`disko`](https://github.com/nix-community/disko), but for now we'll assume that
for a new machine, we'll probably be working with a unique and new set of
devices, filesystems, etc. and we'll want to tweak and create the machine in a
way that will be a bit bespoke at first.

The basic steps are expected to be:

1. Download nixos graphical installer and setup bootable media.
2. Use the installer to partition the system and install it into
   a basic functional image with a generated `configartion.conf` and
   `hw-configuration.conf`.
3. Modify configuration to enable flakes/nix-command and install git
   and a basic editor.
4. Add a new nixos configuration to the flake with appropriate settings
   for this host and its home-manager space.  The generated hw-configuration
   will likely be used as part of this.
   
For step 3, the typical changes to `/etc/nixos/configuration.conf` would be the
following bits:

``` nix
nix.settings = {
  experimental-features = ["nix-command" "flakes"];
};

environment.systemPackages = with pkgs; {
  emacs-nox
  git
};
```

With that done, we should be able to switch into the new system, pull down this
git repo, setup our new host/profile, and get going in this new nixos and
home-manager configuration on the box.

As a quick reminder using the non-flakes stuff:

``` sh
# build and switch into the global non-flakes setup
nixos-rebuild switch

# pull down our git repo
mkdir -p Projects/Personal && cd Projets/Personal
git clone https://github.com/posborne/nix-config.git
cd nix-config

# configure our new machine
export new_mach="new-machine"
mkdir -p hosts/<new-machine>
touch hosts/${new_mach}/default.conf
cp /etc/nixos/hardware-configuration.conf hosts/${new_mach}/
emacs flake.nix # ...

# build our new nixos system manually
nixos-rebuild switch --flakes .#${new_mach}

# run home-manager for first time, after this we'll have
# home-manager, just, etc. available to use
nix run home-manager/master -- switch --flake .#posborne@${new_mach}
```

These steps could probably be really reduced in the future if we
update the flake to allow us to generate our own installer ISO with
enough of the tools/secrets to make bootstrapping a much fatser oredeal.

## Standalone Linux System Bootstrapping

So far, this has been tested on a single Fedora system so it
may need to be adjusted.  To actually start to get going with
our home-manager configuration we need nix.  In my attempts,
the best way to get this going is via [the determinate systems nix installer](https://determinate.systems/posts/determinate-nix-installer/).

This is a new installer for nix written in Rust that solves many problems with
the installer provided as part of the regular nix project.  It also, by default,
enables the nix-command and flakes experimental (for some reason) features that
are pivotal to how things are setup in this repo.

Here's the steps from scratch to run home-manager on a machine; it is assume
that "posborne@new-host" is already setup in nix.flakes using an appropriate
profile.

```sh
# Download and run the determinate systems installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Run home-manager from nix for the first time with our flake and config
nix run home-manager/master -- switch --flake .#posborne@new-host
```

After this initial setup `home-manager` and a bunch of other packages should
be available.  You might need to restart the X Session or machine for things
to start working properly after installing all this stuff for the first
time.

## Darwin

The repo is now setup to support install appropriate software via
home-manager with support from nix-darwin.

To setup a new MacOS machine, you need to get nix on the system first.
Again, we'll do this with the determinate systems installer as follows.

``` sh
# install; note that the determinate systems install has nix-command
# and flakes enabled by default, so no extra step for that
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# test to make sure nix is present
`which nix`
```

We'll more permanently bootstrap in the nix-darwin command for later use, but
for the first run we can do the following from this repo root (we assume this
tree has been pulled down in some other way for now).

``` sh
# Replace my-mac with whatever machine you want to setup; if you have
# special requirements modify as required.
nix run nix-darwin -- switch --flake .#my-mac
```


