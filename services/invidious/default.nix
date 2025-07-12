{ config, pkgs, ... }: {
  services.invidious = {
    enable = true;
    port = 8090;
    sig-helper.enable = true;

    # Homepage metadata
    homepage = {
      name = "Invidious";
      description = "Privacy-focused YouTube frontend";
      port = 8090;
      icon = "invidious";
    };
  };
}
