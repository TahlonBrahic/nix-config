{ pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable;
    wireplumber.enable;
  };

  # This block seems to contradict itself but it is meant to grab pactl
  environment.systemPackges = with pkgs; [
    pulseaudio
  ];
  
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
}

