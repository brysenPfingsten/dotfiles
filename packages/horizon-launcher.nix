{
  appimageTools,
  fetchurl,
}: let
  pname = "horizon-launcher";
  version = "0.2.50";

  src = fetchurl {
    url = "https://github.com/horizon-rust/horizon/releases/download/launcher%40${version}/horizon-launcher-linux-x86_64.AppImage";
    hash = "sha256-a6egjbkiqxuD9YGeUIgfo0c2Cu6+B36GZnUmvvG4LIE=";
  };

  contents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      # Desktop entry + icon from the AppImage so it shows up in the app launcher.
      for d in ${contents}/*.desktop; do
        install -Dm444 "$d" "$out/share/applications/${pname}.desktop"
      done
      sed -i -E 's|^Exec=[^ ]*|Exec=${pname}|' "$out/share/applications/${pname}.desktop"

      if [ -d ${contents}/usr/share/icons ]; then
        mkdir -p "$out/share"
        cp -r ${contents}/usr/share/icons "$out/share/"
      fi
    '';
  }
