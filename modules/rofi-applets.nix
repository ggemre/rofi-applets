{ config, lib, pkgs, ... }:

let
  cfg = config.programs.rofi-applets;
in {
  options.programs.rofi-applets = {
    enable = lib.mkEnableOption "Rofi Applets";

    font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font 12";
      description = "Font used in Rofi themes.";
    };

    colors = {
      background = lib.mkOption {
        type = lib.types.str;
        default = "#1e1e2e";
      };
      backgroundAlt = lib.mkOption {
        type = lib.types.str;
        default = "#181825";
      };
      foreground = lib.mkOption {
        type = lib.types.str;
        default = "#cdd6f4";
      };
      selected = lib.mkOption {
        type = lib.types.str;
        default = "#89b4fa";
      };
      active = lib.mkOption {
        type = lib.types.str;
        default = "#a6e3a1";
      };
      urgent = lib.mkOption {
        type = lib.types.str;
        default = "#f38ba8";
      };
    };

    launcher.enable = lib.mkEnableOption "Launcher applet";
    powermenu.enable = lib.mkEnableOption "Power Menu applet";
    networkmanager.enable = lib.mkEnableOption "Network Manager applet";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkMerge [
      (lib.mkIf cfg.launcher.enable [ (import ../modules/build-packages.nix { inherit pkgs cfg; }).launcher])
      (lib.mkIf cfg.powermenu.enable [ (import ../modules/build-packages.nix { inherit pkgs cfg; }).powermenu ])
      (lib.mkIf cfg.networkmanager.enable [ (import ../modules/build-packages.nix { inherit pkgs cfg; }).networkmanager ])
    ];
  };
}

