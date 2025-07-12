{ config, pkgs, ... }: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "nixtpad";

    # Homepage metadata
    homepage = {
      name = "Jellyfin";
      description = "Media streaming server";
      port = 8096;
      icon = "jellyfin";
    };
  };
}
