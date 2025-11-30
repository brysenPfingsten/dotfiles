{
  inputs,
  pkgs,
  ...
}: let
  mydooit = pkgs.dooit.override {
    extraPackages = [
      pkgs.dooit-extras
    ];
  };
in {
  # this overlay allows you to use dooit from pkgs.dooit
  nixpkgs.overlays = [inputs.dooit.overlay inputs.dooit-extras.overlay];

  environment.systemPackages = [
    mydooit
  ];
}
