{
  flake.nixosModules.devtools =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        shfmt
        gnumake
        stow
        unzip
        gcc
        cargo
        pnpm
        ruff
        dprint
        nixd
        nixfmt
        jujutsu
        just
        just-lsp
        just-formatter
        gh
        jq
        tack
      ];
      programs = {
        npm.enable = true;
        devenv.enable = true;
        java = {
          enable = true;
          binfmt = true;
        };
      };
    };
}
