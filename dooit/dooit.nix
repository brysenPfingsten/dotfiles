{...}: {
  xdg.configFile."dooit" = {
    source = ./.;
    recursive = true;
  };
}
