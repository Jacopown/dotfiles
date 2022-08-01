#!/bin/zsh

echo "Installing Rosetta 2 ..."
softwareupdate --install-rosetta --agree-to-license

echo "Installing XCode"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Turn off homebrew analytics"
brew analytics off

# Update homebrew recipes
echo "Updating homebrew..."
brew update

# Remove "Last Login" message when a terminal is opened
touch ~/.hushlogin
