{pkgs, ...}: let
  codex-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "codex.nvim";
    version = "git-2025-08-20";

    src = pkgs.fetchFromGitHub {
      owner = "johnseth97";
      repo = "codex.nvim";
      rev = "main";
      sha256 = "0nmmbchyjcrllk9ligg9714mjf5c0gv9f2xfb2aq1pnmpjl6rw46";
    };
  };
  pywal16-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "pywal16";
    version = "git-2025-12-28";

    src = pkgs.fetchFromGitHub {
      owner = "uZer";
      repo = "pywal16.nvim";
      rev = "main";
      sha256 = "sha256-FDheT19Tl3rHTQDpAt2tSh3/YTEci9QDTzZspTG4xUw=";
    };
    nvimSkipModule = [
      "pywal16.feline"
    ];
  };
in {
  programs = {
    lazyvim.enable = true;
    neovim.plugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-fzf-native-nvim
      (nvim-treesitter.withAllGrammars)
      compiler-nvim
      nvim-autopairs
      nvim-colorizer-lua
      overseer-nvim
      vimtex
      nvim-ufo
      onedark-nvim
      luasnip
      friendly-snippets
      nvim-jdtls
      neotest
      neotest-python
      rustaceanvim
      crates-nvim
      codex-nvim
      nvim-dap
      nvim-dap-ui
      nvim-nio
      nvim-dap-virtual-text
      csvview-nvim
      pywal16-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
}
