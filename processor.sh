#!/bin/sh
set -e

echo "# Files in $KBC_DATADIR/in/files/slice (ls)"
ls $KBC_DATADIR/in/files/slice | wc -l
echo "# Files in $KBC_DATADIR/in/files/slice (find 1)"
find . ! -iname "*.manifest" ! -name "." -type d | wc -l
echo "# Files in $KBC_DATADIR/in/files/slice (find 2)"
find . ! -iname "*.manifest" ! -name "."

if [ $KBC_PARAMETER_DIRECTION == "files" ]; then
    cd $KBC_DATADIR/in/tables/
    # move folders
    find . ! -iname "*.manifest" ! -name "." -type d | xargs -n1 -I {} sh -c "mv \"{}\" $KBC_DATADIR/out/files/\"{}\""
    # move files
    find . ! -iname "*.manifest" ! -name "." | xargs -n1 -I {} sh -c "mv \"{}\" $KBC_DATADIR/out/files/\"{}\""
fi

if [ $KBC_PARAMETER_DIRECTION == "tables" ]; then
    [ -z "$KBC_PARAMETER_ADDCSVSUFFIX" ] && export KBC_PARAMETER_ADDCSVSUFFIX=0;
    cd $KBC_DATADIR/in/files/
    if [ $KBC_PARAMETER_ADDCSVSUFFIX == "true" ] || [ $KBC_PARAMETER_ADDCSVSUFFIX == "1" ]; then
        # move folders
        echo "Moving folders (with CSV suffix)"
        find . ! -iname "*.manifest" ! -name "." -type d | xargs -n1 -I {} sh -c "mv \"{}\" $KBC_DATADIR/out/tables/\"{}\".csv"
        # move files
        echo "Moving files (with CSV suffix)"
        find . ! -iname "*.manifest" ! -name "." | xargs -n1 -I {} sh -c "mv \"{}\" $KBC_DATADIR/out/tables/\"{}\".csv"
        exit 0
    else
        # move folders
        echo "Moving folders"
        find . ! -iname "*.manifest" ! -name "." -type d | xargs -n1 -I {} sh -c "mv \"{}\" $KBC_DATADIR/out/tables/\"{}\""
        # move files
        echo "Moving files"
        find . ! -iname "*.manifest" ! -name "." | xargs -n1 -I {} sh -c "mv \"{}\" $KBC_DATADIR/out/tables/\"{}\""
    fi
fi
