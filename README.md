# nixos-rpi-sd-image

A convenient way to create custom Raspberry Pi NixOS SD images.

So far this has been tested to work with Docker Desktop for Mac and also Docker
on Linux.

## Setup

1.  Install QEMU into the host machine:

    ```sh
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    ```

2.  Clone this repo.

3.  Configure `nixos-rpi-sd-image/sd-image.nix` and
    `nixos-rpi-sd-image/configuration.nix` with your own settings.

## Run

1.  Use `docker-compose` to mount `output` and run the container:

    ```sh
    docker-compose up
    ```

2.  Check the `output` directory for the `.img` file.

## SD Image Usage

1.  Burn the `.img` file in `output` to an SD card with your preferred method.

2.  Insert the SD card into the Raspberry Pi and wait for it to boot.

3.  Wait for NixOS to rebuild (this may take a long time) and switch or SSH into
    the Raspberry Pi, then run the following command to monitor progress:

    ```sh
    journalctl -f -u sd-image-init.service
    ```

4.  Enjoy!

## Credit

This was possible mostly in part because of the blog posts and code of
@Robertof, but also the contributors to `nixos-generators` and the wiki for
NixOS on ARM.

[NixOS on ARM > Building your own image > Compiling through QEMU][]
[NixOS on a Raspberry Pi: creating a custom SD image with OpenSSH out of the box by @Robertof][]
[NixOS Docker-based SD image builder][]
[nixos-generators - one config, multiple formats][]

[NixOS on ARM > Building your own image > Compiling through QEMU]: https://nixos.wiki/wiki/NixOS_on_ARM#Compiling_through_QEMU
[NixOS on a Raspberry Pi: creating a custom SD image with OpenSSH out of the box by @Robertof]: https://rbf.dev/blog/2020/05/custom-nixos-build-for-raspberry-pis/
[NixOS Docker-based SD image builder]: https://github.com/Robertof/nixos-docker-sd-image-builder
[nixos-generators - one config, multiple formats]: https://github.com/nix-community/nixos-generators
