#!/bin/bash

rm -rf variables.txt
unzip medievalv16.zip
mv "Medieval MC [FORGE] 1.19.2 Server Pack"/* .
echo "Variables:"
sed 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' variables.txt
sed -i 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' variables.txt
chmod +x start.sh