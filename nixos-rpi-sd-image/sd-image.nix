{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    ./sd-image-init.nix
  ];

  # bzip2 compression takes loads of time with emulation, skip it. Enable this if you're low
  # on space.
  sdImage.compressImage = false;

  sdImage.populateRootCommands = ''
    mkdir -p ./files/etc/sd-image-metadata/
    cp /configuration.nix ./files/etc/sd-image-metadata/configuration.nix
    cp /sd-image-init.nix ./files/etc/sd-image-metadata/sd-image-init.nix
  '';

  # OpenSSH is forced to have an empty `wantedBy` on the installer system[1], this won't allow it
  # to be automatically started. Override it with the normal value.
  # [1] https://github.com/NixOS/nixpkgs/blob/9e5aa25/nixos/modules/profiles/installation-device.nix#L76
  systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  # Enable OpenSSH out of the box.
  services.sshd.enable = true;

  # The installer starts with a "nixos" user to allow installation, so add the SSH key to
  # that user. Note that the key is, at the time of writing, put in `/etc/ssh/authorized_keys.d`
  # users.extraUsers.nixos.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 ..."
  # ];

  # Use a default root SSH login.
  # services.openssh.permitRootLogin = "yes";
  # users.users.root.password = "nixos";

  # Wireless networking (1). You might want to enable this if your Pi is not attached via Ethernet.
  networking.wireless = {
   enable = true;
   interfaces = [ "wlan0" ];
   networks = {
     "replace-with-my-wifi-ssid" = {
       psk = "replace-with-my-wifi-password";
     };
   };
  };

  # Wireless networking (2). Enables `wpa_supplicant` on boot.
  systemd.services.wpa_supplicant.wantedBy = lib.mkOverride 10 [ "default.target" ];

  # NTP time sync.
  services.timesyncd.enable = true;
}
