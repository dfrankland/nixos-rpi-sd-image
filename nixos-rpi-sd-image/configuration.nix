{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Needed to continue SD image initialization after installer removes its own unit.
    ./sd-image-init.nix
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

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
  # networking.wireless = {
  #  enable = true;
  #  interfaces = [ "wlan0" ];
  #  networks = {
  #    "replace-with-my-wifi-ssid" = {
  #      psk = "replace-with-my-wifi-password";
  #    };
  #  };
  # };

  # Wireless networking (2). Enables `wpa_supplicant` on boot.
  # systemd.services.wpa_supplicant.wantedBy = lib.mkOverride 10 [ "default.target" ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  # NTP time sync.
  services.timesyncd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.03"; # Did you read the comment?

  # NGINX sample
  networking.firewall.allowedTCPPorts = [ 80 ];
  services.nginx.enable = true;
}
