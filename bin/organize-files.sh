#!/bin/bash

# Based on some code that I unfortunately don't have the reference

folders='Compressed Documents Images Music Programs Videos Pkix Data Code Diagrams Quarantine Rdp'
ext_comp="*.zip *.tar.gz *.gz *.7z"
ext_doc="*.htm* *.php *.txt *.css *.doc* *.pdf *.PDF *.ppt* *.js *.xls* *.rtf"
ext_img="*.jp*g *.JPG *.png *.gif *.svg *.tiff *.tif"
ext_music="*.mp3 *.aac *.wma *.wav"
ext_progrm="*.deb *.exe *.run"
ext_vid="*.mp4 *.mkv *.flv *.avi *.webm *.wmv *.mov *.MOV"
ext_pkix="*.pem *.ppk *.crt *.der *.cer *.key *.p12"
ext_data="*.json *.xml *.csv"
ext_code="*.py *.ipynb *.apk *.jsp *.java"
ext_diag="*.drawio"
ext_quarantine="*.dmg"
ext_rdp="*.rdp"

for folder in $folders
do
    if [ $folder == 'Compressed' ]
    then
        mkdir -p $folder
        mv $ext_comp $folder 2>/dev/null

    elif [ $folder == 'Documents' ]
    then
        mkdir -p $folder
        mv $ext_doc $folder 2>/dev/null

    elif [ $folder == 'Images' ]
    then
        mkdir -p $folder
        mv $ext_img $folder 2>/dev/null

    elif [ $folder == 'Music' ]
    then
        mkdir -p $folder
        mv $ext_music $folder 2>/dev/null

    elif [ $folder == 'Programs' ]
    then
        mkdir -p $folder
        mv $ext_progrm $folder 2>/dev/null
    
    elif [ $folder == 'Videos' ]
    then
        mkdir -p $folder
        mv $ext_vid $folder 2>/dev/null

    elif [ $folder == 'Pkix' ]
    then
        mkdir -p $folder
        mv $ext_pkix $folder 2>/dev/null

    elif [ $folder == 'Data' ]
    then
        mkdir -p $folder
        mv $ext_data $folder 2>/dev/null

    elif [ $folder == 'Code' ]
    then
        mkdir -p $folder
        mv $ext_code $folder 2>/dev/null

    elif [ $folder == 'Diagrams' ]
    then
        mkdir -p $folder
        mv $ext_diag $folder 2>/dev/null
   
    elif [ $folder == 'Quarantine' ]
    then
        mkdir -p $folder
        mv $ext_quarantine $folder 2>/dev/null

    elif [ $folder == 'Rdp' ]
    then
        mkdir -p $folder
        mv $ext_rdp $folder 2>/dev/null

    else
            echo "$(tput setaf 3)Problem creating folder..$(tput sgr0)"
        fi

done

mkdir -p /tmp/part
mv -v *.part /tmp/part

echo "$(tput setaf 2)Successfully organized..$(tput sgr0)"
