{src}: final: prev: {
  racket-langserver = final.stdenv.mkDerivation {
    pname = "racket-langserver";
    version = "from-src";
    inherit src;

    buildInputs = [final.racket];

    installPhase = ''
        mkdir -p $out/share/racket/collects
        cp -r . $out/share/racket/collects/racket-langserver

        mkdir -p $out/bin
        cat > $out/bin/racket-langserver <<EOF
      #!${final.runtimeShell}
      # Use -S to add our packaged collection path (no env var churn, no duplicates)
      exec ${final.racket}/bin/racket -S $out/share/racket/collects -l racket-langserver "\$@"
      EOF
        chmod +x $out/bin/racket-langserver
    '';
  };
}
