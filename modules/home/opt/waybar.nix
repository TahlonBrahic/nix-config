{
  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        mainBair = {
          layer = "bottom";
          position = "bottom";
          height = 30;
          margin-top = -10;
          margin-bottom = 0;
          margin-right = 100;
          margin-left = 100;

          window = {
            border = 3;
            titlebar = false;
          };

          # Modules
          modules-left = ["cpu"];
          modules-center = ["clock"];

          "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };
          "sway/workspaces" = {
            on-click = "activate";
            sort-by-number = true;
          };
        };
      };
    };
  };
}
