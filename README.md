# VoiceCommands

## "Speech to command" mobile project

> Note about production ready:
> The application should be ready for production. 
But a subscription to apple license program  is required to be able to create the ipa and distribute it



Mobile project for iOS

Language : Swift  
Minimum iOS version: 15.0

## Install and launch app
- Open the .xcodeproj file with xcode
- Select a running destination device (iPhone , minimum iOS version is 15.0)
- open the signing and capabilities tab in the target "VoiceCommands" setting and select  "automatically manage signing" or a personal provisioning profile
- run the application

## First usage
During the first run the application will ask you the permissions to use the voice recognition  

![Simulator Screenshot - iPhone 14 Pro - 2023-10-04 at 19 02 15](https://github.com/Jacopo90/VoiceCommands/assets/6302498/b3f42911-6f8b-4b43-94f4-bc70363267d8)


### MAIN PAGE: 

![Simulator Screenshot - iPhone 14 Pro - 2023-10-04 at 17 24 24](https://github.com/Jacopo90/VoiceCommands/assets/6302498/f8f206cb-4890-4b6d-9434-d5989a1996ed)
 
The table shows the executed commands recognized from the voice and every single cell displays the command name and the passed parameters.


In the bottom area you can see three differents parts: 
- current command text: here you can visualize the recognized command
- text speech text: here you can see what the recognize system understands from your voice
- listen button and clean button: the listen button starts the listening of your voice and clean button interrupts it.

In the header there are two main buttons: 
-  commands: brings you to a page in which you can visualize all the active/registered commands
-  language: brings you to a list of available language to change the application language (this language changes also the speech recognition system: the commands will have a different command key)

![Simulator Screenshot - iPhone 14 Pro - 2023-10-04 at 17 24 27](https://github.com/Jacopo90/VoiceCommands/assets/6302498/1ea01727-3e06-4264-82f5-8dcfb116ddfb)
![Simulator Screenshot - iPhone 14 Pro - 2023-10-04 at 17 24 30](https://github.com/Jacopo90/VoiceCommands/assets/6302498/e82dd254-f9b8-4822-8a80-4cdda8472f12)

## commands
The default active commands are: 
 - code 
 - count
 - reset 
 - back

Is possible also to add new commands like: 
- stop (actually this commands interrupts the voice listening )
- config






