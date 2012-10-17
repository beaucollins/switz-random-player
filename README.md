#SwitzerlandPlayer

For use on switzerlandllc.com

## Building

First, install the flex sdk (if you don't have it):

    > brew instal flex_sdk

Follow the homebrew instructions to make sure you configure everything
correctly.

Then, checkout the source and initialize the submodule and build:

    > git clone https://github.com/beaucollins/switz-random-player.git
    > cd switz-random-player
    > git submodule init
    > ./build

The `SWF` will be available at `./output/SwitzerlandPlayer.swf`.
