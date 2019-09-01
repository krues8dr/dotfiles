export PATH=./node_modules/.bin:~/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/sbin:/Users/krues8dr/ec2-tools/bin:$PATH:~/android-sdk-macosx/platform-tools:~/android-sdk-macosx/tools:/private/etc/pear/bin:/usr/local/share/python:/usr/local/share/npm/bin:/Library/TeX/Root/bin/x86_64-darwin:/Library/PostgreSQL/11/bin
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

export PGDATA=/Library/PostgreSQL/11/data/

export EDITOR=vi

export JAVA_HOME=/Library/Java/Home
export CATALINA_HOME=/Library/Tomcat/Home
export ANDROID_HOME=~/android-sdk-macosx
export PIP_DOWNLOAD_CACHE=/Users/krues8dr/.pip-cache


# alias j.py; enable j.sh
export JPY=~/.j/j.py
. ~/.j/j.sh

# MacPorts Installer addition on 2013-11-25_at_16:28:02: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Add path to LLVM
export PATH="/usr/local/opt/llvm/bin:$PATH"