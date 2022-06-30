{ config, pkgs, ...  }:

{
  services.minidlna = {
    enable = true;
    mediaDirs = [
      "V,/data/media/movies"
      "V,/data/media/shows"
      "V,/data/media/anime"
    ];
    friendlyName = "zeus";
    rootContainer = "B";
    extraConfig = ''
      port=5001
      inotify=yes
    '';
  };
}