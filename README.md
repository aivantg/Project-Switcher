# Project-Switcher

This is my short-and-sweet Bash Script that helps me navigate my development folders. I generally like to keep things very organized in specified folders, but consequently navigating these folders through the command line can get pretty tedious. One solution is to create specific aliases in your .bash_profile for each project, but that can get clunky. This is a workaround to create a `cd` command specifically to navigate dev folders with aliases!

## Installation

1. Download these 3 files and put them in a easy-to-remember folder on your computer.
2. In base_path.txt, update the file path to your "home" directory. This is similar to the `~` directory that `cd` takes you to.
3. In main.sh, update the `HOMEFILEPATH` variable to be the directory where you put these 3 files
4. Type `nano ~/.bash_profile` (or open that file in whatever text editor you prefer) and add the line: `source /path/to/files/main.sh` pointing to the main.sh file you just downloaded.
4. Clear out project_aliases.txt and start creating your own aliases!

## Usage

### Primary Command: `dev`
This is the primary command that you'll be using. `dev` is a replacement for `cd` that is rooted at your development directory. All paths created will be rooted in your development directory. There are two primary differences from `cd`

**1)** Instead of passing in a full path as the full argument, you can pass in pieces of the path as separate argument. 


For example, instead of `cd home/myfiles/images` you could do `dev home myfiles images` or `dev home myfiles/images`

**2)** Before appending to the path of the directory that you will switch to, each of those arguments are looked up in a dictionary of aliases that you define.


For example, after calling the following commands, detailed below:

`update-dev-path /users/myuser/development` (you only need to call this command once)

`mkalias p Experiments/Projects`

`mkalias android java/src`

You could use dev like so:

`dev p` == `cd /users/myuser/development/Experiments/Projects`

You could also chain aliases with regular folders:

`dev p testproject android` == `cd /users/myuser/development/Experiments/Projects/testproject/java/src`

### Helper Commands: `mkalias` `lsalias` `rmalias`

**mkalias**: `mkalias <shortname> <path>`

What it does: Creates a new alias for you to use with the dev command
Example: `mkalias p Experiments/Projects`

**lsalias**: `lsalias`

What it does: Shows you all of your existing aliases

**rmalias**: `rmalias <shortname>`

What it does: Removes aliases found with the given shortname
Example: `rmalias p`

### Config Commands: `update-dev-path` `dev-path`

**update-dev-path**: `update-dev-path <path>`

What it does: Changes the root directory that the `dev` command starts creating paths from

**dev-path**: `dev-path`

What it does: Shows you the current dev root path. 
