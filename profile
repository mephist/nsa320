# Don't want a global LD_LIBRARY_PATH
unset LD_LIBRARY_PATH

# Set default language
export LANG=en_US

# Set default less options
export LESS="-M"

# If the user doesn't have a .inputrc, use the one in /ffp/etc.
if [ ! -r "$HOME/.inputrc" ]; then
	INPUTRC=/ffp/etc/inputrc
fi
export INPUTRC

# Set the default system $PATH:
PATH=/ffp/bin:/usr/bin:/bin
if [ $(/ffp/bin/id -u) -eq 0 ]; then
	PATH=/ffp/sbin:/usr/sbin:/sbin:$PATH
fi
PATH=$PATH:/opt/bin:/opt/sbin
export PATH

# Set TERM to linux for unknown type or unset variable:
if [ "$TERM" = "" -o "$TERM" = "unknown" ]; then
	TERM=linux
fi
export TERM

# Set the default prompt
export PS1='\u@\h:\w\$ '
export PS2='> '

# Set default umask
umask 022

# include custom profile files
for profile_script in /ffp/etc/profile.d/*.sh; do
	if [ -x $profile_script ]; then
		. $profile_script
	fi
done
unset profile_script

. /tmp/.ffpstick/helper.inc
. /ffp/etc/ffp.version
echo "== Welcome at FFP version ${FFPVERSION}, running on ${NASTYPE} ` hostname `, firmware ${FIRMWARE} =="
