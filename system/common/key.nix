{ config, inputs, pkgs, ...  }:

{
  environment.etc."ssh/ssh_known_hosts".source = pkgs.lib.mkForce
    "${inputs.keys}/${config.networking.hostName}/ssh_known_hosts";

  environment.etc."ssh/id_rsa".source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa";
  environment.etc."ssh/id_rsa.pub".source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa.pub";
}
