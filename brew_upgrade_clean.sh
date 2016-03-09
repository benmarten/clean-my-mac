#!/bin/bash

brew update
brew cask update
brew upgrade
brew cleanup
brew cask cleanup
brew doctor