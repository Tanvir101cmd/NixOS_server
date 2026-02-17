{ config, pkgs, ... }:

{
  # Enable the OpenSSH daemon. 
  services.openssh = {
    enable = true;
    ports = [ 2222 ]; 
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = "yes"; 
      KbdInteractiveAuthentication = false;
    };
  };

  # Enable firewall with necessary ports 
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 2222 ]; 
    allowedUDPPorts = [ ];
    checkReversePath = "loose"; 
    trustedInterfaces = [ "tailscale0" "wlan0" ];
  };

  # Fail2Ban to automatically ban sus IPs
  services.fail2ban = {
    enable = true;
    # Bans the IP for 1 hour after 5 failed attempts
    maxretry = 5;
    ignoreIP = [
      "127.0.0.1/8"
      "100.64.0.0/10" # This ignores your Tailscale network so I don't ban myself lmao
    ];
  };
}
