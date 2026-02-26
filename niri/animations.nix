{
  animations = {
    slowdown = 1.5;

    window-open = {
      kind = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 700;
          epsilon = 0.0001;
        };
      };
    };

    window-close = {
      kind = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 700;
          epsilon = 0.1;
        };
      };
    };

    window-resize = {
      kind = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.001;
        };
      };
    };

    window-movement = {
      kind = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 600;
          epsilon = 0.0001;
        };
      };
    };

    overview-open-close = {
      kind = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 900;
          epsilon = 0.0001;
        };
      };
    };

    workspace-switch = {
      kind = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.00001;
        };
      };
    };

    horizontal-view-movement = {
      kind = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 700;
          epsilon = 0.0001;
        };
      };
    };
  };
}
