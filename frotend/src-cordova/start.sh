unset ANDROID_HOME
unset ANDROID_SDK_ROOT
unset PATH

export ANDROID_HOME="$HOME/Android/Sdk"

export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export PATH=$PATH:$ANDROID_SDK_ROOT/tools; PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# quasar dev -m cordova -T android