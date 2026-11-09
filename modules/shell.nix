{
  flake.nixosModules.shell =
    { pkgs, ... }:
    {
      environment.shellAliases = {
        rm = "rm -i"; # use \rm -rf for removing a large dir or files without confirmation
        cp = "cp -i";
        mv = "mv -i";

        # These are set by default.
        # Read the source code of environment.shellAliases block.
        ls = null;
        ll = null;
        l = null;
      };

      environment.pathsToLink = [ "/share/bash-completion" ];

      environment.systemPackages = with pkgs; [
        starship
        zoxide
        television
        vivid
        fzf
        pay-respects
        carapace
        tealdeer
        fastfetch
        eza
        fd
        ripgrep
      ];

      programs = {
        bash.completion.enable = true;
        bat.enable = true; # config: stow/bat

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };

      security.sudo = {
        enable = true;
        execWheelOnly = true;
        package = pkgs.sudo.override { withInsults = true; };
        extraConfig = ''
          Defaults pwfeedback
        '';
      };
    };
}
