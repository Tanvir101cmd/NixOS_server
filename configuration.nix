{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/security.nix
    ./modules/services.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tanvir = {
    isNormalUser = true;
    description = "Tanvir";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB6KaudWVwILSHjzNOCF3RDH27uiJOTlRXzkpVbeHvAf mac -> hp"
    ];
    packages = with pkgs; [
      git
      fastfetch
      fzf
      btop
      pfetch-rs
      python3
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    rsync
    mosh
    tailscale
    auto-cpufreq
    docker-compose
    tree
  ];

  # Enabling vim to be default EDITOR
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  
  # Minecraft server 
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;

   package = pkgs.papermcServers.papermc-1_21_10;

    serverProperties = {
      server-ip = "100.120.226.4";
      server-port = 26565;
      difficulty = "normal";
      gamemode = "survival";
      max-players = 4;

      sync-chunk-writes = false;

      online-mode = false;
      };
   };
 
 
  # Some shell aliases for long commands
  environment.shellAliases = {
    nix-switch = "sudo nixos-rebuild switch";
    nix-clean = "sudo nix-collect-garbage -d";
    nix-conf = "sudoedit /etc/nixos/configuration.nix";
    neofetch = "clear ; fastfetch";
  };

  # Settings up garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  # Automatic update at 4am
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "Fri 04:00";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
