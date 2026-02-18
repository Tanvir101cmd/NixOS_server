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
  # 4533 - Navidrome
  # 5030, 50300 - slskd
  # 6881 = qbittorrent
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 2222 4533 5030 50300 8080 6881 8383 26565]; 
    allowedUDPPorts = [ 50300 6881 26565 ];
    checkReversePath = "loose"; 
    trustedInterfaces = [ "tailscale0" ];
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
