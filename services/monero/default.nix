{ config, pkgs, ... }: {
  services.monero = {
    enable = true;
    prune = true;
    dataDir = "/mnt/disk2/moneroDataDir";
    mining = {
      enable = true;
      threads = 1;
      address =
        "8ARrh7viB6bbgWzLLNHnEQ73PkogiNnvRRPnRot4wmXTMaVwtE92iBGWmurDxNycJb3xEzbJHoejr3E1JtfrAbi59yoPj4F";
    };
    limits = {
      download = 100;
      syncSize = 2;
    };
  };
}
