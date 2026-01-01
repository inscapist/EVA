_:
{
  dconf.settings = {
    "org/freedesktop/ibus/general" = {
      preload-engines = [
        "xkb:us::eng"
        "libpinyin"
      ];
      engines-order = [
        "xkb:us::eng"
        "libpinyin"
      ];
    };

    "org/freedesktop/ibus/general/hotkey" = {
      trigger = [ "Control+space" ];
      triggers = [ "<Control>space" ];
    };
  };
}
