{
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.resistFingerprinting" = false;
      "webgl.disbled" = false;
    };
  };
}
