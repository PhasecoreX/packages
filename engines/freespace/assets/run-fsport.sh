#!/bin/bash

if [[ ! -z "${DEPPATH_273620}" ]]; then
    echo "Automatic path for freespace 2 found at $DEPPATH_273620"

    if [ ! -f "$DEPPATH_273620/fs2_open_x64" ]; then
        "$STEAM_ZENITY" --error --title="Error" --text="Freespace 2 not found or not launched."
        exit 1
    fi
else
    "$STEAM_ZENITY" --error --title="Error" --text="Freespace 2 path not found."
    exit 1
fi


if [ ! -d "$DEPPATH_273620/fsport" ]; then
    LD_LIBRARY_PATH=.7z ./7z/7z x -o"$DEPPATH_273620/fsport" ./fsport3_6.7z
    LD_LIBRARY_PATH=.7z ./7z/7z x -o"$DEPPATH_273620/fsport" ./fsport-missions.7z
    LD_LIBRARY_PATH=.7z ./7z/7z x -o"$DEPPATH_273620/fsport" ./sparky_hi_fs1.7z
fi

cd "$DEPPATH_273620"

ln -rsf ./fsport/fsport3_6.vp ./fsport3_6.vp
ln -rsf ./fsport/fsport-missions.vp ./fsport-missions.vp
ln -rsf ./fsport/sparky_hi_fs1.vp ./sparky_hi_fs1.vp

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./fs2_open_x64 "$@"

rm ./fsport3_6.vp
rm ./fsport-missions.vp
rm ./sparky_hi_fs1.vp