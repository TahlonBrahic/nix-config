{
  pkgs,
  lib,
  users,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pam_u2f
    yubikey-manager
  ];

  services = {
    pcscd.enable = true;
    yubikey-agent.enable = true;
    udev = {
      packages = with pkgs; [yubikey-personalization];
    };
  };

  security.pam = lib.optionalAttrs pkgs.stdenv.isLinux {
    sshAgentAuth.enable = true;
    u2f = {
      enable = true;
      settings = {
        cue = false;
        #authFile = "/home/${customVars.username}/.config/Yubico/u2f_keys";
      };
    };
    services = {
      login.u2fAuth = true;
      sudo = {
        u2fAuth = true;
        sshAgentAuth = true;
      };
    };
  };
}
