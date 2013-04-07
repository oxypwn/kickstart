# Set language
[ -z $LANGUAGE ] && LANGUAGE=en_US.UTF-8
export LANG=${LANGUAGE}; echo -e "LANG=${LANGUAGE}\nLC_COLLATE=C" > /etc/locale.conf

# Set keymap
[ -z $KEYMAP ] && KEYMAP=dvorak
[ -z $FONT ] && FONT=Lat2-Terminus16
[ -z $FONT_MAP ] && FONT_MAP=8859-1_to_uni
echo -e "KEYMAP=${KEYMAP}\nFONT=${FONT}\nFONT_MAP=${FONT_MAP}" > /etc/vconsole.conf


# Set time
[ -z $TIMEZONE ] && TIMEZONE=Europe/Stockholm
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo ${TIMEZONE} >> /etc/timezone
hwclock --systohc --utc # set hardware clock
pacman -S ntp

