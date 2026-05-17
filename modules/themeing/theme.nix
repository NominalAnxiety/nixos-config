{
  config,
  lib,
  pkgs,
  ...
}:

let
  qylockSrc = pkgs.fetchFromGitHub {
    owner = "Darkkal44";
    repo = "qylock";
    rev = "f5ad66c690e2e514cbde9c882dba2dbb55a42092";
    hash = "sha256-8FTTxdTlvaxHXlEZ4AOMq48Q23dqJa0+83TzBKcZer0=";
  };

  mkTheme =
    folderName:
    pkgs.stdenvNoCC.mkDerivation {
      name = "sddm-qylock-${folderName}";
      src = qylockSrc;
      dontConfigure = true;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/sddm/themes
        cp -r themes/${folderName} $out/share/sddm/themes/${folderName}
      '';
    };

  themes = {
    pixel-munchlax = {
      folderName = "pixel-munchlax";
    };
    pixel-coffee = {
      folderName = "pixel-coffee";
    };
    pixel-dusk-city = {
      folderName = "pixel-dusk-city";
    };
    pixel-night-city = {
      folderName = "pixel-night-city";
    };
    pixel-rainyroom = {
      folderName = "pixel-rainyroom";
    };
    pixel-skyscrapers = {
      folderName = "pixel-skyscrapers";
    };
    enfield = {
      folderName = "enfield";
    };
    clockwork = {
      folderName = "clockwork";
    };
    nier-automata = {
      folderName = "nier-automata";
    };
    terraria = {
      folderName = "terraria";
    };
    windows-7 = {
      folderName = "windows_7";
    };
    star-rail = {
      folderName = "star-rail";
    };
    osu = {
      folderName = "osu";
    };
  };

  selected = themes.${config.custom.sddm.theme};
  selectedPkg = mkTheme selected.folderName;

in
{

  options.custom.sddm.theme = lib.mkOption {
    type = lib.types.str;
    default = "pixel-munchlax";
  };

  config = {
    services.displayManager.sddm = {
      enable = true;
      theme = selected.folderName;
      settings = {
        Theme = {
          Current = selected.folderName;
          ThemeDir = "${selectedPkg}/share/sddm/themes";
        };
        General.InputMethod = "";
      };
    };

    environment.systemPackages = [
      selectedPkg
      pkgs.kdePackages.sddm-kcm
    ];
  };
}
