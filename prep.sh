#!/bin/bash
FILENAME=medievalv16.zip
FOLDERNM="Medieval MC [FORGE] 1.19.2 Server Pack"
VARTMP="template.txt"
VARPMT="variables.txt"
PROPTMP="server.properties.tmp"
PROPPMT="server.properties"
URL="https://www.curseforge.com/api/v1/mods/486989/files/4581850/download"

#Function to download modpack
dl_modpack() {
    curl -L $URL -o $FILENAME
    unzip $FILENAME
    mv "$FOLDERNM"/* .
    rm -rf "$FOLDERNM"
}

#Moves into data directory
cd /data

#checks if there is a current modpack installation
if [ -f "$FILENAME" ]; then
    echo "Installation Exists"
    rm -rf $VARPMT
    rm -rf $PROPPMT

    #Ensures there is a valid variable template file
    if [ -f "$VARTMP" ]; then
        cp $VARTMP $VARPMT
    else
        echo "Missing $VARTMP file: Unzipping modpack for replacement"
        unzip_modpack
        cp $VARPMT $VARTMP
    fi

    #Ensures there is a valid server.properties template file
    if [ -f "$PROPTMP" ]; then
        cp $PROPTMP $PROPPMT
    else
        echo "Missing $PROPTMP file: Unzipping modpack for replacement"
        unzip_modpack
        cp $PROPPMT $PROPTMP
    fi
else
    
    #If there is no installation, it downloads the modpack and creates the installation
    dl_modpack
    unzip_modpack
    cp $VARPMT $VARTMP
    cp $PROPPMT $PROPTMP
fi

#creates eula.txt file to accept minecraft's EULA
rm -rf eula.txt
echo eula=true > eula.txt

#Sets Variables
echo ""
echo "Variables:"
sed 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' $VARPMT
sed -i 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' $VARPMT
sed -i 's%enable-rcon=false%enable-rcon=true%' $PROPPMT
echo rcon.password=$RCON_PASS>>$PROPPMT
echo 'rcon.port=25575'>>$PROPPMT
echo 'broadcast-rcon-to-ops=false'>>$PROPPMT

#Changes permissions and starts server
chmod +x start.sh
source start.sh