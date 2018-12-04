#!/bin/bash

#set -x
#
#function get_influx_config_value_from_user {
#    question=$1
#    default_value=$2
##echo "bla"
#    echo -n "$question [$default_value]"
#    read user_input
#    final_value=""
#
#    if [ -z "$user_input" ]
#    then
#        final_value=$user_input
#    else
#        # return:
#        echo $default_value
#        return
#    fi
#}
#
#
#use_rss_feed_widget=$(get_influx_config_value_from_user "$Q_WANT_TO_USE_X an 'RSS Feed Widget'?" "yes")
#echo $use_rss_feed_widget

flutter_binary=$(which flutter)
flutter_bin_env_set=$?

if [[ "$flutter_bin_env_set" -eq "0" ]]
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
