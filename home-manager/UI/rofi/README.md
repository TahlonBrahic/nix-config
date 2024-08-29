The rofi Nix package does not have good enough documentation at the time to define how exactly to define multiple configurations therefore I am using a hybrid approach (declarative and imperative) for defining rofi:

- Home Manager's `home.file` method
