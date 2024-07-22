{ pkgs, lib, ... }:

with lib;
{
  console.useXkbConfig = true;

  time.timeZone = mkDefault "Asia/Singapore";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";

  i18n.inputMethod.type = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];

  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-rime
  #     fcitx5-chinese-addons
  #     librime
  #   ];
  # };
}
