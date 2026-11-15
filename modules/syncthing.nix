{
  flake.nixosModules.syncthing = { ... }: {
    services.syncthing = {
      enable = true;
      user = "krish";
      group = "users";
      dataDir = "/home/krish";
      configDir = "/home/krish/.config/syncthing";
      openDefaultPorts = true;

      settings = {
        devices.phone.id = "YCL4FB7-NNKG7GU-572LNJB-KJYBM7O-CUKKMOU-QXYKICW-KIHX2TQ-SDSQOQW";
        folders.org = {
          path = "/home/krish/org";
          devices = [ "phone" ];
          ignorePatterns = [ ".git" ]; # ignore .git patterns so that phone doesn't get git stuff
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "30";
          };
        };
      };
    };
  };
}
