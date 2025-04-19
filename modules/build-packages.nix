{ pkgs, cfg ? null }:

let
  launcherTheme = pkgs.substituteAll {
    src = ../pkgs/themes/launcher.rasi;
    background = if cfg != null then cfg.colors.background else "#1e1e2e";
    backgroundAlt = if cfg != null then cfg.colors.backgroundAlt else "#181825";
    foreground = if cfg != null then cfg.colors.foreground else "#cdd6f4";
    selected = if cfg != null then cfg.colors.selected else "#89b4fa";
    active = if cfg != null then cfg.colors.active else "#a6e3a1";
    urgent = if cfg != null then cfg.colors.urgent else "#f38ba8";
    font = if cfg != null then cfg.font else "JetBrainsMono Nerd Font 12";
  };

  launcherScript = pkgs.substituteAll {
    src = ../pkgs/launcher.sh;
    theme = launcherTheme;
  };

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

  powerScript = pkgs.substituteAll {
    src = ../pkgs/powermenu.sh;
    theme = powerTheme;
  };

  networkTheme = pkgs.substituteAll {
    src = ../pkgs/themes/networkmanager.rasi;
    background = if cfg != null then cfg.colors.background else "#1e1e2e";
    backgroundAlt = if cfg != null then cfg.colors.backgroundAlt else "#181825";
    foreground = if cfg != null then cfg.colors.foreground else "#cdd6f4";
    selected = if cfg != null then cfg.colors.selected else "#89b4fa";
    active = if cfg != null then cfg.colors.active else "#a6e3a1";
    urgent = if cfg != null then cfg.colors.urgent else "#f38ba8";
    font = if cfg != null then cfg.font else "JetBrainsMono Nerd Font 12";
  };

  networkScript = pkgs.substituteAll {
    src = ../pkgs/networkmanager.sh;
    theme = networkTheme;
  };
in {
  # TODO: check all runtimeInputs
  launcher = pkgs.writeShellApplication {
    name = "rofi-launcher";
    runtimeInputs = with pkgs; [ rofi-wayland ];
    text = builtins.readFile launcherScript;
  };

  powermenu = pkgs.writeShellApplication {
    name = "rofi-powermenu";
    runtimeInputs = with pkgs; [ rofi-wayland ];
    text = builtins.readFile powerScript;
  };

  networkmanager = pkgs.writeShellApplication {
    name = "rofi-networkmanager";
    runtimeInputs = with pkgs; [ rofi-wayland libnotify ];
    text = builtins.readFile networkScript;
  };
}

