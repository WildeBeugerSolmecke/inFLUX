#!/bin/bash

echo -e "\n"
echo    "############################################################"
echo    "####                                                    ####"
echo    "####      Welcome to the inFLUX App Wizard v0.0.1!      ####"
echo    "####                                                    ####"
echo    "####   You can customize your app by simply answering   ####"
echo    "####   the questions below!                             ####"
echo    "####                                                    ####"
echo -e "############################################################\n\n"

flutter_binary=$(which flutter)
is_flutter_bin_env_var_set=$?

if [[ "$is_flutter_bin_env_var_set" -eq "0" ]]
then
    flutter_bin_dir=$(dirname $flutter_binary)
    dart_binary=$flutter_bin_dir"/cache/dart-sdk/bin/dart"
    if [[ -e "$dart_binary" ]]
    then
        eval $dart_binary config_generator.dart
    else
        echo "I couldn't find the Dart executable! :("
    fi
else
    echo "You don't have Flutter installed! :("
fi
