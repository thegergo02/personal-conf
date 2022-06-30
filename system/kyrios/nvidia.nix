{ config, pkgs, ...  }:

{
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
