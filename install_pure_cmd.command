#!/bin/bash
echo "This will install the additional teams on Your Mac.\n"
read -p "Are you sure you wound like to continue? (y/n) " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo
echo
echo "Proceeding with installation."
echo
echo
dirtoinstall_base="/home/`id -un`/myapps"
echo -n "The directory I will install to will be \"$dirtoinstall_base\". Please enter another path !!! RELATIVE TO HOME DIRECTORY !!!! or just press enter to keep it []:"
read dirtoinstall
if [ -z "$dirtoinstall" ]; then
dirtoinstall="myapps"
fi
echo
echo "Will install into the directory: \"$dirtoinstall\"."
echo
echo

# Installing BREW
PROGRAM="brew"
if ! command -v ${PROGRAM} >/dev/null; then
echo
echo "Now we will install brew as it doesn't appear to exist in the system. PLEASE BE PATIENT! It will take about 5 minutes to install!!!"
echo 
echo
echo "It will now ask for the password - the one you use to login to your system."
echo
echo
echo "When you will type the PASSWORD below it WONT be displayed - that is OKAY!"
echo
echo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/`id -un`/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# INSTALLING NPM
PROGRAM2="npm"
if ! command -v ${PROGRAM2} >/dev/null; then
echo
echo "Now we will install npm as it doesn't appear to exist in the system."
echo
brew install npm
fi

# INSTALLING NATIVEFIER
PROGRAM3="nativefier"
if ! command -v ${PROGRAM3} >/dev/null; then
echo
echo "Now we will install nativefier as it doesn't appear to exist in the system."
echo
npm install nativefier -g
fi

echo
echo -n "Let's pick a name for the new application. If you just press enter the name \"Additional Microsoft Teams\" will be used []: "
read newappname
if [ -z "$newappname" ]; then
newappname="Additional Microsoft Teams"
fi
echo
echo "So we will use the name \"$newappname\" for the new app name."
echo

# CREATING DIRECTORY
cd ~
mkdir -p $dirtoinstall
cd $dirtoinstall

mkdir -p ~/Applications

# CREATING APP

nativefier -n "$newappname" --internal-urls "./.*/" "https://teams.microsoft.com/_#"
echo
echo "DONE! Congratulations! Please don't forget to pin it to the dock!"
echo
thefile=$(ls -t -U ~/$dirtoinstall/ | grep -m 1 "$newappname")
cd ~

fromF="$HOME/$dirtoinstall/$thefile/$newappname.app"
toF="$HOME/Applications/$newappname.app"

ln -s "${fromF}" "${toF}"
chmod 755 "${toF}"
chmod a+X "${toF}"
open "$dirtoinstall/$thefile"

open "$dirtoinstall/$thefile"
