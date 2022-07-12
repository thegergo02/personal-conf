{ config, inputs, ... }:

{
  imports = [ "${inputs.secrets}/services/zitadel/zitadel.nix" ];
  config.services.zitadel = {
    enable = true;
    extraConfig = ''
      ExternalSecure: true
      ExternalDomain: sso.freeself.one
      S3DefaultInstance:
        CustomDomain: sso.freeself.one
    '';
    extraCommand = "--tlsMode external --masterkeyFile ${config.age.secrets.services-zitadel-masterkey.path}";
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
