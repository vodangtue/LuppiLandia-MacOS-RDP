#macos.sh MAC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN MAC_REALNAME

#disable spotlight indexing
sudo mdutil -i off -a

#Create new account
sudo dscl . -create /Users/vdtue
sudo dscl . -create /Users/vdtue UserShell /bin/bash
sudo dscl . -create /Users/vdtue RealName $4
sudo dscl . -create /Users/vdtue UniqueID 1001
sudo dscl . -create /Users/vdtue PrimaryGroupID 80
sudo dscl . -create /Users/vdtue NFSHomeDirectory /Users/tcv
sudo dscl . -passwd /Users/vdtue 1234
sudo dscl . -passwd /Users/vdtue 1234
sudo createhomedir -c -u luppilandia > /dev/null
sudo dscl . -append /Groups/admin GroupMembership username

#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvncpw -vncpw vdtue1234

echo $2 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

#Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

#install ngrok
brew install --cask ngrok

#configure ngrok and start it
ngrok authtoken 1wpSMz3jtKsCslT4sZQvUt5wgD8_32Dcn9pL7qW4PJHN2bvTk
ngrok tcp 5900 --region=eu &
