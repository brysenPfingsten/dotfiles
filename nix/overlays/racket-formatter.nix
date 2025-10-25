# overlay-fmt.nix
{src}: final: prev: {
  raco-fmt = final.stdenv.mkDerivation {
    pname = "raco-fmt";
    version = "from-src";
    inherit src;

    buildInputs = [final.racket];

    installPhase = ''
        set -eu
        mkdir -p "$out/share/racket/collects"
        # Install the collection so it's named "fmt"
        cp -r . "$out/share/racket/collects/fmt"

        mkdir -p "$out/bin"
          cat > "$out/bin/raco-fmt" <<EOF
        #!${final.runtimeShell}
        # Use racket (not raco) so we can pass -S, then load raco as a library
      exec ${final.racket}/bin/racket -S "$out/share/racket/collects" -l raco/raco fmt "\$@"
      EOF
        chmod +x "$out/bin/raco-fmt"
    '';
  };
}
