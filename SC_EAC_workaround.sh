#!/bin/bash




#Hardcore this variable to your EAC_DIR if your dir is somewhere else
EAC_DIR=/home/$(whoami)/Games/star-citizen/drive_c/users/$(whoami)/AppData/Roaming/EasyAntiCheat

#set this to "true" to enable dangermode (no more "double-check the dir" and "read this before you go" confirmations)
DANGERMODE=false





function wait_for_enter {
	while true; do
		read -s -N 1 key
		if [[ $key == $'\x0a' ]];        # if input == ENTER key
		then
			break;
		fi
	done
}

if ! $DANGERMODE;then
	echo "Use this at your own risk, it's possible that usage of this workaround might get your Star Citizen Account permanently banned, and you should always check in with the Linux User Group to see if there has been a better way to circumvent the EAC launchup bug. You should also always check here if the bug has been resolved: https://issue-council.robertsspaceindustries.com/projects/STAR-CITIZEN/issues/STARC-23611. I am not responsible for your usage of this script."
	echo
	echo
	echo "Press [enter] if you have taken these words of caution into consideration."
	wait_for_enter;
fi

echo -n "checking if inotifywait is available..."
if ! command -v inotifywait &> /dev/null; then
	echo -e "\rchecking if inotifywait is available... ❌"
	echo "this script needs the "inotifywait" command. Check here to see how to get it for your distribution:"
	echo "https://command-not-found.com/inotifywait"
	exit 1
else
	echo -e "\rchecking if inotifywait is available... ✔"
fi

echo -n "checking if not ran with sudo..."
if [[ "$USER" == "root" ]]; then
	echo -e "\rchecking if not ran with sudo... ❌"
	echo "Rerun this script without Sudo!"
	exit 1
else
	echo -e "\rchecking if not ran with sudo... ✔"
fi



echo -n "checking if EAC_DIR exists..."
if ! [[ -d $EAC_DIR ]]; then
	echo -e "checking if EAC_DIR exists... ❌"
	echo 
	echo
	echo "-----"
	echo "EAC_DIR couldn't be auto-detected. Stop the script if you don't know what this is and ask for help."
	echo
	read -p "Please enter the EAC_DIR (for persistence, edit the script):" EAC_DIR
	if ! [[ -d $EAC_DIR ]]; then
		echo "EAC_DIR is not a valid dir, terminating"
		exit 1
	fi
else
	echo -e "\rchecking if EAC_DIR exists... ✔"
fi

echo "-----"

if ! $DANGERMODE;then
	echo "Removing all contents of EAC folder after confirmation."
	echo "DOUBLE CHECK IF THIS IS THE RIGHT FOLDER: $EAC_DIR"
	echo
	echo "Press [Enter] to confirm or ctrl-c to cancel."
	wait_for_enter;
else
	echo "Removing all contents of EAC folder..."
fi
rm -r $EAC_DIR/*

echo "EAC cleared."
echo "Checking if /etc/hosts already contains the fix..."

if grep -q "modules-cdn.eac-prod.on.epicgames.com" /etc/hosts; then
	echo "Fix has already been applied! Please double-check /etc/hosts and remove 'modules-cdn.eac-prod.on.epicgames.com'"
	exit 1
fi

sudo bash -c ' echo "127.0.0.1 modules-cdn.eac-prod.on.epicgames.com" >> /etc/hosts'
echo "Hostsfix applied!"
echo
echo "-----"
echo "Watching EAC folder for files, you can now log in. Be aware that this program won't work if sudo is timing out."
inotifywait -e create -qq $EAC_DIR
echo "EAC folder populated, removing hosts fix in 2 seconds..."
sleep 2
head -n -1 /etc/hosts > temp.txt ; sudo mv temp.txt /etc/hosts
echo
echo
echo "Hosts fix removed! Enjoy the 'verse!"
echo
echo "Made with ❤️  by @s_is"
