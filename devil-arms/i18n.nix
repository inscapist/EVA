{ pkgs, lib, ... }:

with lib;
{
  console.useXkbConfig = true;

  time.timeZone = mkDefault "Asia/Singapore";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";

  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
}
