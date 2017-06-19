#!/bin/bash

sudo softwareupdate -i -a;

brew update
brew upgrade
brew cleanup
brew cask cleanup
mkdir -p '/Library/Caches/Homebrew/Casks'
brew doctor

