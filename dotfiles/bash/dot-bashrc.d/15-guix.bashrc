# -*- mode: sh; sh-shell: bash -*-

GUIX_PROFILE="$HOME/.config/guix/current"
[ -f "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"

GUIX_PROFILE="$HOME/.guix-profile"
[ -f "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"

export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
