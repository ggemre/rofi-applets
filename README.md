# Rofi applets for Nix

## About rofi-applets

This project began as an overlay embedded in my system configuration Nix flake.
As it has grown, I've extracted it into its own Nix flake for easier maintenance and sharing with others.

**What is this?** This flake provides a home-manager module for installing various apps and utilities onto your machine
that utilize rofi to do small tasks such as launching apps, power management, configuring networks, and more.

## Supported applets

### Launcher

*insert overview, config options, and screenshots*

### Power Menu

*insert overview, config options, and screenshots*

### Network Menu

*insert overview, config options, and screenshots*

### Calculator

*🛠️ coming soon...*

### Bluetooth Menu

*🛠️ coming soon...*

### Screenshot Tool

*🛠️ coming soon...*

### Clipboard History Menu

*🛠️ coming soon...*

### VPN Menu

*🛠️ coming soon...*

### Emoji Selector

*🛠️ coming soon...*

## Installing rofi-applets

Rofi-applets provides a [home-manager](https://github.com/nix-community/home-manager) module for installation.

1. Add rofi-applets as a flake input:

```nix
# flake.nix
{
  inputs = {
    # ...
    rofi-applets.url = "github:ggemre/rofi-applets";
    # ...
  }
}
```

2. Add the home-manager module

After adding rofi-applets as a flake input, add `inputs.rofi-applets.homeManagerModules.default` to imports in a Home-Manager configuration file.
At this point, rofi-applets can be configured like so:

```nix
# home/rofi-applets.nix
{inputs}: {
  imports = [inputs.rofi-applets.homeManagerModules.default];

  programs.rofi-applets = {
    enable = true;
    launcher.enable = true; # install the launcher applet
  };
}
```

>[!NOTE]
> If no applet is specified, (e.g. launcher, powermenu, etc), then the module will not install any packages.

## Configuration

Options to configure rofi-applets are shown in the example below:

```nix
{
  inputs,
  config,
  ...
}: {
  imports = [inputs.rofi-applets.homeManagerModules.rofi-applets];

  programs.rofi-applets = {
    enable = true;
    font = config.stylix.fonts.monospace.name;
    colors = {
      background = config.lib.stylix.colors.withHashtag.base00;
      backgroundAlt = config.lib.stylix.colors.withHashtag.base01;
      foreground = config.lib.stylix.colors.withHashtag.base05;
      selected = config.lib.stylix.colors.withHashtag.base07;
      active = config.lib.stylix.colors.withHashtag.base0D;
      urgent = config.lib.stylix.colors.withHashtag.base08;
    };

    launcher.enable = true;
    powermenu.enable = true;
    networkmanager.enable = true;
  };
}
```

For a real example of rofi-applets being implemented in someone's system configuration, see [this flake](https://github.com/ggemre/fleet/blob/main/modules/home/graphical/rofi-applets.nix).

## Credits

* Thanks to [@gh0stzk](https://github.com/gh0stzk) with their [rofi configs](https://github.com/gh0stzk/dotfiles/tree/master/config/bspwm/src).
* Thanks to [@elyziumayo](https://github.com/elyziumayo) for their [Rofi-networkmanager](https://github.com/elyziumayo/Rofi-networkmanager) which provided a ground to write mine.
* Thanks to [@adi1090x](https://github.com/adi1090x) for great [rofi rasi files](https://github.com/adi1090x/rofi) to inspire mine.

