{ config, pkgs, ... }: {
  environment.etc."paperless-admin-pass".text = "admin";
  services.paperless = {
    enable = true;
    passwordFile = "/etc/paperless-admin-pass";
    port = 28981;
    dataDir = "/mnt/disk2/paperlessDataDir";
  };
}
