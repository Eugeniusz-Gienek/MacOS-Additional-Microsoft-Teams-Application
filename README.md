# MacOS-Additional-Microsoft-Teams-Application

Additional Microsoft Teams application for using on MacOS (You may use it for example for another corporate account - so there will be one app (native) teams for Your company and another one for the client).

Inspired by [this](https://github.com/tavikukko/teams-desktop) instruction.
Instrucrtion to create:

The easiest way:
	
Download the file [Additional Teams Install.zip](https://github.com/WindyWanderer/MacOS-Additional-Microsoft-Teams-Application/blob/be8eb293e4a65256401220e0cffed5ebe1be6011/Additional%20Teams%20Install.zip)
	
Unzip the file
	
Run the application "Additional Teams Install.app", allow access to the current directory.
	
It will ask for the location if the "install.sh" file - please point it (unpacked from the archive, for sure  )
	
Follow the instructions.

The "other" way:

* Firstly, install npm (I assume you have installed brew, haven't you? If not - here's the instruction: https://brew.sh/index_pl ): `brew install npm`
* Next, install Nativefier: `npm install nativefier -g`
* Last, go to the folder where the application will live - let's say, you would like to create the myapps folder: `mkdir ~/myapps && cd ~/myapps`
* ...and then create an app using nativefier: `nativefier -n "Teams-desktop" --internal-urls "./.*/" "https://teams.microsoft.com/_#"`.
  By the way - you may change the nanme from "Teams-desktop" to whatever you want - for example, "MySuperCLientName Teams"  or whatever.

---

Done! You've got in that folder (myapps in this example) the folder with the MS Teams app which you can just run from there and log in with your another account - and you have two teams running simultanously, with two different accounts!
Besides, the camera and microphone work there as well - in order to give access for them, create a test meeting and join it - it will ask to access the mic and then the camera.

P.S. there is NO menu with devices selection as in the desktop app - the only place where you can select the microphone and camera is ... the call. The same as in the web version of the MS Teams (which it eventually is!)

P.P.S. in order for the notifications to work - receive the first one (e.g. send a message from your another teams to this client teams, the popup will appear and from there you go to the system notifications settings and allow 
notifications.

Stick it to dock and you'll b good to go. Enjoy!
