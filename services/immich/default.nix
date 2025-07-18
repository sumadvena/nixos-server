{ config, pkgs, ... }: {
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    accelerationDevices = null;
    mediaLocation = "/mnt/disk2/immichMediaLocation";

    # Homepage metadata
    homepage = {
      name = "Immich";
      description = "Photo and video backup solution";
      port = 2283;
      icon = "immich";
    };
  };
}
