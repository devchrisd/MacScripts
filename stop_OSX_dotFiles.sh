#!/bin/sh
#
# Tip for putting off those apple ugly shitty dirs
# ( .Spotlight-V100 / .Trashes / .fseventsd )
#
# Change to the concerned directory for running this script

# To keep Spotlight from indexing non system volumes, add /Volumes to the Privacy list in
# System Preferences > Spotlight.
# /Volumes is the point in the file system where all non-system disks are mounted by default.
#
# to add /Volumes in 10.8 or later. Simply open a Finder window, press Shift+Command+G to
# bring up the "Go to folder..." window, type /Volumes, and then drag the little folder
# icon at the top of the Finder window (next to the word "Volumes") into the list
#
# To show hidden files on/off Mac OS X:
#    defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder
#    defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder

dir1='.fseventsd'
dir2='Spotlight-V1*'
dir3='Trashes'

tag1='.metadata_never_index'
tag2='.Trashes'
tag3='no_log'

echo "Turn indexing off for $1"
mdutil -i off /Volumes/$1
cd /Volumes/$1

echo "Removing recursively dirs [$dir1, $dir2, $dir3] …"
rm -rf $dir1
rm -rf .{,_.}{$dir2, $dir3}

# — spotlight off
#
touch $tag1
echo "Tagfile [$tag1] created."

# — trash off
#
touch $tag2
echo "Tagfile [$tag2] created."

# — fseventsd off
#
mkdir $dir1 && touch $dir1/$tag3 && \
(echo "Tagfile [$dir1/$tag3] created.") || \
(echo "ERROR tagfile [$dir1/$tag3] "; exit 1)

chmod 400 $tag1 $tag2 $dir1/$tag3

#