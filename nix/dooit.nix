{
  inputs,
  pkgs,
  ...
}: let
  dooit-base = inputs.dooit.packages.${pkgs.system}.default.overrideAttrs (old: {
    doCheck = false; # Skip tests
  });

  mydooit = dooit-base.override {
    extraPackages = [
      inputs.dooit-extras.packages.${pkgs.system}.default
    ];
  };
in {
  environment.systemPackages = [
    mydooit
  ];
}
