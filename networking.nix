{ ... }:

{
  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
    };

    firewall = {
      allowedTCPPortRanges = [
        # GSConnect
        { from = 1714; to = 1764; }
      ];
      allowedUDPPortRanges = [
        # GSConnect
        { from = 1714; to = 1764; }
      ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
