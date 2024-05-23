{
  pkgs,
  lib,
  ...
}: {

    service.xserver.displayManager.sddm = {
        enable = true;
        autoNumlcok = true;
        
    };
}