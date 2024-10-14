{
  pkgs,
  lib,
  vars,
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

  # yubikey login / sudo
  security.pam = lib.optionalAttrs pkgs.stdenv.isLinux {
    sshAgentAuth.enable = true;
    u2f = {
      enable = true;
      settings = {
        cue = false; # Tells user they need to press the button
        authFile = "/home/${vars.username}/.config/Yubico/u2f_keys";
      };
    };
    services = {
      login.u2fAuth = true;
      sudo = {
        u2fAuth = true;
        sshAgentAuth = true; # Use SSH_AUTH_SOCK for sudo
      };
    };
  };
}
