# wsl-template
Template for generating containers to run under WSL.

## Build the tarball:

Set some environment variables for the user you want to use in the wsl container, and
them run the build script.  

`USER=pdutton PASSWORD=changeme EMAIL=pdutton0@gmail.com FULLNAME='Peter Dutton' ./build.sh` 

 :grey_exclamation: USER is probably already set to your current username.

 :exclamation: Use your own values please. And don't use changeme. I call dibs on that password!

## Import into WSL

In powershell, create a directory where the container will live:

`mkdir C:\WSLDistros\[ContainerName]`

Then import the new tarball:

`wsl --import [ContainerName] C:\WSLDistros\[ContainerName] ./TEMPLATE-wsl.tar`


## TODO

  - [X] Add git config values based on user.
  - [ ] Add the ability to set the ssh id for the new user so that you can automatically log into things like git.
  - [ ] Add support for encrypted input password.



