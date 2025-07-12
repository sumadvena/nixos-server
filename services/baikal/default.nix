{ config, pkgs, ... }: {
  services.baikal = {
    enable = true;

    # Homepage metadata
    homepage = {
      name = "Baikal";
      description = "CalDAV and CardDAV server";
      port = 80;
      icon = "baikal";
    };
  };
}

