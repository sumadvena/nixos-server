{ config, pkgs, lib, ... }:

let
  # Server IP address - adjust this to your server's IP
  serverIP = "192.168.1.12";

  # Function to extract homepage metadata from service configs
  extractHomepageServices = cfg:
    lib.flatten (lib.mapAttrsToList (serviceName: serviceConfig:
      if serviceConfig.enable or false && serviceConfig.homepage or null
      != null then [{
        ${serviceConfig.homepage.name} = {
          description = serviceConfig.homepage.description;
          href = "http://${serverIP}:${toString serviceConfig.homepage.port}";
          icon = serviceConfig.homepage.icon or serviceName;
        };
      }] else
        [ ]) cfg.services);

  homepageServices = extractHomepageServices config;

in {
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
    services = [{ "Services" = homepageServices; }];
  };
}
