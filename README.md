# Remove Shortcut Arrow

## Description 
It helps you remove or change the shortcut arrow for your apps and programs  
remove and change shortcut arrow for windows 10, 11,...

## Table of Contents
- [Downloading](#downloading)
- [Usage](#usage)
- [Features](#features)
- [Notes](#notes)

## Downloading
Download the [Releases](https://github.com/benzaria/remove_shortcut_arrow/releases)  
```
:: Or Clone the repository
git clone https://github.com/benzaria/remove_shortcut_arrow.git 
```

## Usage
Start the Executable
```
     ╔═══════════════════════════════════════════════════════════════════════╗
     ║ remove_shortcut_arrow made by benzaria and converted using Bat_To_Exe ║
     ║    It's used to remove or change the shortcut arrow from shortcuts    ║
     ╚═══════════════════════════════════════════════════════════════════════╝
      >>for more info check https://github.com/benzaria/remove_shortcut_arrow

    remove_shortcut_arrow.exe [/?, -help] [-hidden] [-dir] [-undo] [-ico]
    
       -hidden     hide the admin command prompt ( don't show Errors )
    
       -dir <dir>  change the saving directory of blanc.ico [default <C:\WINDOWS>]
    
       -undo       undo and restore the changes happend on the shortcut icon
    
       -ico <ico>  change the default <blanc.ico> for your desired icon

     !! The program needs elevated privileges to make changes on the registry !!
    
```
>[!TIP]
> .For changing the shortcut arrow make sure that the image you chouse represent ~25% from the icon you make.  
> .Always put the paths in double quotes.

## Features
- Easy to use, simply by double clicking the .exe file Or from the command prompt for advance operation
- Flexible, it give you more variety of saving options and icon changing
- Undoable, it give you the choice to undo the changes and backup the shortcut arrow

## Notes 
By default the program will remove the shortcut arrow from all the shortcuts in the System.  
  Why blanc.ico :  
    The blanc.ico is needed because of the new Explorer in windows 10+ that shows an empty png as a black square  
    for that reason I created the blanc.ico which is a png containing one single pixel so it don't get black  

    






