{ config, pkgs, ... }:

{
  # Making sure closing the laptop lid doesn't put it to sleep
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "lock";
      HandleLidSwitchDocked = "ignore";
    };
  };

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Select internationalisation properties.
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

  # Enabling intel microcode
  hardware.cpu.intel.updateMicrocode = true;

  # Mounting my other ntfs drives
  fileSystems."/mnt/Files" = {
    device = "/dev/disk/by-uuid/01D858C886F164A0";
    fsType = "ntfs3"; 
    options = [ "defaults" "uid=1000" "gid=1000" "umask=022" "nofail" "force" "x-systemd.automount" ];
  };

  fileSystems."/mnt/More" = {
    device = "/dev/disk/by-uuid/01D858C8BFF86460";
    fsType = "ntfs3";
    options = [ "defaults" "uid=1000" "gid=1000" "umask=022" "nofail" "force" "x-systemd.automount" ];
  };

  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/01D858C8DC3DA2C0";
    fsType = "ntfs3";
    options = [ "defaults" "uid=1000" "gid=1000" "umask=022" "nofail" "force" "x-systemd.automount" ];
  };

  # Enabling Zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
