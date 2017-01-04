#!/bin/fish

set NODE_VERSION_REMOTE (nvm version-remote 6)
set NODE_VERSION (nvm version node)

# echo $NODE_VERSION
# echo $NODE_VERSION_REMOTE

if [ $NODE_VERSION_REMOTE = $NODE_VERSION ] 
	echo "Latest node version is installed! ($NODE_VERSION)"
	exit 1
end

echo "Upgrading node $NODE_VERSION -> $NODE_VERSION_REMOTE ..."

nvm install $NODE_VERSION_REMOTE
# nvm use node
nvm alias default $NODE_VERSION_REMOTE
echo "Reinstalling global modules ..."
nvm reinstall-packages $NODE_VERSION
nvm uninstall $NODE_VERSION
echo "Done!"

# # Temp fix for nvm linking issue
ln -s ~/.nvm/versions/node/(node -v)/bin/node /usr/local/bin/ 
ln -s ~/.nvm/versions/node/(node -v)/bin/npm /usr/local/bin/

