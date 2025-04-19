{ pkgs, cfg ? null }:

let
  powerTheme = pkgs.substituteAll {
    src = ../pkgs/themes/powermenu.rasi;
    background = if cfg != null then cfg.colors.background else "#1e1e2e";
    backgroundAlt = if cfg != null then cfg.colors.backgroundAlt else "#181825";
    foreground = if cfg != null then cfg.colors.foreground else "#cdd6f4";
    selected = if cfg != null then cfg.colors.selected else "#89b4fa";
    active = if cfg != null then cfg.colors.active else "#a6e3a1";
    urgent = if cfg != null then cfg.colors.urgent else "#f38ba8";
    font = if cfg != null then cfg.font else "JetBrainsMono Nerd Font 12";
  };

  powermenuScript = pkgs.substituteAll {
    src = ../pkgs/powermenu.sh;
    theme = powerTheme;
  };
in {
  powermenu = pkgs.writeShellApplication {
    name = "rofi-powermenu";
    runtimeInputs = with pkgs; [ rofi-wayland ];
    text = builtins.readFile powermenuScript;
  };
}

