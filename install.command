#!/bin/bash
res=`osascript -e 'display dialog "This will install the additional teams on Your Mac. Proceed?" buttons {"Nope", "Continue"} default button "Continue" cancel button "Nope" with icon caution' | grep Continue`
if [ -z "$res" ]; then
    exit 1
fi
echo
echo
echo "Proceeding with installation."
echo
echo
dirtoinstall_base="/home/`id -un`/myapps"
res2=`osascript -e 'set theResponse to display dialog "The directory I will install to will be: myapps in home directory. Please enter another path !!! RELATIVE TO HOME DIRECTORY !!!! or just press Continue to keep it." default answer "" with icon note buttons {"Cancel", "Continue"} default button "Continue"'`
if [[ "$res2" == *"button returned:Cancel"* ]]; then
echo
echo "Cancelled by user."
echo
exit 1
fi
if [ -z "$res2" ]; then
echo
echo "Cancelled by user."
echo
exit 1
fi

sep='text returned:'
dirtoinstall=${res2#*"$sep"}
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
res4=`osascript -e 'display dialog "Now we will install brew as it does not appear to exist in the system. PLEASE BE PATIENT! It usually takes about 5 minutes to install. Please take a look at the Termial - it will ask for a password! Please pay attention to that when you will enter passord it will NOT be displayed - it is OK." buttons {"Stop immediately!", "OK"} default button "OK" cancel button "Stop immediately!" with icon caution giving up after 30'`
if [[ "$res4" == *"button returned:Stop"* ]]; then
echo
echo "Cancelled by user."
echo
exit 1
fi
if [ -z "$res4" ]; then
echo
echo "Cancelled by user."
echo
exit 1
fi


echo
echo "Now we will install brew as it doesn't appear to exist in the system. PLEASE BE PATIENT! It will take about 5 minutes to install!!!"
echo 
echo
echo "It will now ask for the password - the one you use to login to your system."
echo
7echo
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

res3=`osascript -e 'set theResponse to display dialog "Let us pick a name for the new application. If you just press enter the name Additional Microsoft Teams will be used" default answer "" with icon note buttons {"Cancel", "Continue"} default button "Continue"'`
if [[ "$res3" == *"button returned:Cancel"* ]]; then
echo
echo "Cancelled by user."
echo
exit 1
fi
if [ -z "$res3" ]; then
echo
echo "Cancelled by user."
echo
exit 1
fi


sep='text returned:'
newappname=${res3#*"$sep"}

if [ -z "$newappname" ]; then
newappname="Additional Microsoft Teams"
fi
echo
echo "So we will use the name \"$newappname\" for the new app name."
echo

# CREATING DIRECTORY
dirtoinstall2=`printf '%q\n' "${dirtoinstall[@]}"`
cd $HOME
mkdir -p $dirtoinstall2
cd $dirtoinstall2
mkdir -p "$HOME/Applications"


# CREATING APP

nativefier -n "$newappname" --internal-urls "./.*/" "https://teams.microsoft.com/_#"
echo
echo "DONE! Congratulations! Please don't forget to pin it to the dock!"
echo
thefile=$(ls -t -U "$HOME/$dirtoinstall2/" | grep -m 1 "$newappname")
cd $HOME

newappname2=`printf '%q\n' "${newappname[@]}"`
thefile2=`printf '%q\n' "${thefile[@]}"`

fromF="$HOME/$dirtoinstall/$thefile/$newappname.app"
toF="$HOME/Applications/$newappname.app"

ln -s "${fromF}" "${toF}"
chmod 755 "${toF}"
chmod a+X "${toF}"
open "$dirtoinstall/$thefile"


osascript -e 'display dialog "DONE! Congratulations! Please do not forget to pin it to the dock :)" buttons {"Sure!"} default button "Sure!" giving up after 15' &> /dev/null
