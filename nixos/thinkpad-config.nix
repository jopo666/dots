{ config, pkgs, lib, ... }:

{
  imports = [ ./thinkpad-hardware.nix ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Networking.
  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  # User account.
  users.users.jopo = {
    isNormalUser = true;
    description = "jopo";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Time and locale.
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable sound,
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing.
  services.printing.enable = true;
  
  # Enable ssh.
  services.openssh.enable = true;

  # X11 and window manager.
  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
  };

  # Default packages.
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [ vim git wget ];

  # Garbage collection.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "23.05"; # Don't change...
}
