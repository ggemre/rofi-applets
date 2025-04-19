{ pkgs, cfg ? null }:

let
  defaultColors = {
    background    = "#1e1e2e";
    backgroundAlt = "#181825";
    foreground    = "#cdd6f4";
    selected      = "#89b4fa";
    active        = "#a6e3a1";
    urgent        = "#f38ba8";
  };

  getValue = name: if cfg != null && cfg.colors ? ${name} then cfg.colors.${name} else defaultColors.${name};
  font = if cfg != null then cfg.font else "JetBrainsMono Nerd Font 12";

  rofiPkg = if cfg != null && cfg ? rofiPackage then cfg.rofiPackage else pkgs.rofi-wayland;

  mkTheme = themeFile: pkgs.substituteAll {
    src = themeFile;
    background    = getValue "background";
    backgroundAlt = getValue "backgroundAlt";
    foreground    = getValue "foreground";
    selected      = getValue "selected";
    active        = getValue "active";
    urgent        = getValue "urgent";
    inherit font;
  };

  mkApplet = name: {
    themePath,
    scriptPath,
    extraInputs ? []
  }: let
    theme = mkTheme themePath;
    script = pkgs.substituteAll {
      src = scriptPath;
      inherit theme;
    };
  in
    pkgs.writeShellApplication {
      name = "rofi-${name}";
      runtimeInputs = [ rofiPkg ] ++ extraInputs;
      text = builtins.readFile script;
    };

in {
  launcher = mkApplet "launcher" {
    themePath = ../pkgs/themes/launcher.rasi;
    scriptPath = ../pkgs/launcher.sh;
  };

  powermenu = mkApplet "powermenu" {
    themePath = ../pkgs/themes/powermenu.rasi;
    scriptPath = ../pkgs/powermenu.sh;
  };

  networkmanager = mkApplet "networkmanager" {
    themePath = ../pkgs/themes/networkmanager.rasi;
    scriptPath = ../pkgs/networkmanager.sh;
    extraInputs = [ pkgs.libnotify ];
  };
}
