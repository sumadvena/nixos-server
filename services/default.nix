{ config, pkgs, ... }:

{
  imports = [
    ./baikal
    ./immich
    ./invidious
    ./jellyfin
    ./monero
    ./paperless
    ./stirling-pdf
  ];

  services.homepage-dashboard = {
    enable = true;
    listenPort = 8028;
    openFirewall = true;
    allowedHosts = "*";
    services = [ ];
  };
}
