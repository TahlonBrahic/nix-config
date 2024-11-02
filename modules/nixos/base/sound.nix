{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };

    # pulse.enable = true;
    jack.enable = true;
    # wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # pulseaudio
    alsa-utils
    alsa-ucm-conf
  ];

  security.rtkit.enable = true;
  # hardware.pulseaudio.enable = false;
}
