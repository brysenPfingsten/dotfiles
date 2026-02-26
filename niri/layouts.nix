{
  layout = {
    gaps = 1;
    center-focused-column = "never";

    preset-column-widths = [
      {proportion = 1.0 / 3.0;}
      {proportion = 0.5;}
      {proportion = 2.0 / 3.0;}
    ];

    default-column-width = {proportion = 1.0;};

    shadow = {
      enable = true;
      softness = 30;
      spread = 5;
      offset = {
        x = 0;
        y = 5;
      };
      color = "#0007";
    };

    focus-ring = {
      width = 1;
      active = {color = "#7fc8ff";};
      inactive = {color = "#505050";};
    };

    border = {
      enable = false;
    };
  };
}
