#!/bin/bash
FILENAME=medievalv16.zip
FOLDERNM="Medieval MC [FORGE] 1.19.2 Server Pack"
VARTMP="template.txt"

#Function to download modpack
dl_modpack() {
    curl -L https://www.curseforge.com/api/v1/mods/486989/files/4581850/download -o $FILENAME
    unzip $FILENAME
    mv "$FOLDERNM"/* .
    rm -rf "$FOLDERNM"
}

#Moves into data directory
cd /data

#creates eula.txt file to accept minecraft's EULA
echo eula=true > eula.txt

#checks if there is a current modpack installation
if [ -f "$FILENAME" ]; then
    echo "Installation Exists"
    rm -rf variables.txt

    #Ensures there is a valid variable template file
    if [ -f "$VARTMP" ]; then
        cp $VARTMP variables.txt
    else
        echo "Missing variables.txt file: Downloading modpack for replacement"
        dl_modpack
        cp variables.txt $VARTMP
    fi
else
    
    #If there is no installation, it downloads the modpack and creates the installation
    dl_modpack
    cp variables.txt $VARTMP
fi

#Sets Variables
echo ""
echo "Variables:"
sed 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' variables.txt
sed -i 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' variables.txt

#Changes permissions and starts server
chmod +x start.sh
source start.sh