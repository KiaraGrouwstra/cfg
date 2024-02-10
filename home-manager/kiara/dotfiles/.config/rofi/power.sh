#!/usr/bin/env sh

chosen=$(printf "⏻  Power Off\n⭮  Restart\n🌙  Suspend\n❄️  Hibernate\n🚪  Log Out\n🔒  Lock" | anyrun --plugins libstdin.so)

case "$chosen" in
	"⏻  Power Off") systemctl poweroff -i ;;
	"⭮  Restart") systemctl reboot ;;
	"🌙  Suspend") systemctl suspend-then-hibernate ;;
	"❄️  Hibernate") systemctl hibernate ;;
	"🚪  Log Out") niri msg action quit ;;
	"🔒  Lock") swaylock ;;
	*) exit 1 ;;
esac
