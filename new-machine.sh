#!/bin/bash

# This script is used to quickly initialize new Kessel Run Platform development machines
#
# Prerequisites:
# - Using an OSX machine
#
# To-do:
# - Support for Chocolatey on Windows
# - Figure out how to make fly download version independent

# Check what OS this is running on
if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "This script does not support Linux" ; exit 1
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "This script does not support Windows" ; exit 1
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "This script does not support Windows" ; exit 1
fi

# If ruby isnt installed, then install xcode command line utils
if ! ruby -v > /dev/null 2>&1 ; then
    xcode-select --install
fi

# Install Homebrew package manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install CF CLI for manually installing apps using the CF API endpoint
brew tap cloudfoundry/tap
brew install cf-cli

# Install terraform because KR platform automation uses it
brew install terraform

# Install fly to interact with Concourse
curl -Lo fly.tgz https://github.com/concourse/concourse/releases/download/v5.0.1/fly-5.0.1-darwin-amd64.tgz
tar -zxvf fly.tgz
rm fly.tgz
chmod +x fly
mv fly /usr/local/bin/

# Install Firefox to interact with PCF components through browser and SOCKS5 proxy
brew cask install firefox

# Install jq to parse JSON. The KR Platform automation init script uses jq heavily
brew install jq

# Install AWS CLI
brew install awscli

# Install nodeJS because every web app at KR uses it
brew install node

# Install yarn because a lot of people at KR will use it and if you dont have it things will break
npm install yarn -g

# Install Java because... reasons...
brew cask install java
