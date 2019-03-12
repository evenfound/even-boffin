Install Qt 5.12 Ubuntu 18.04:
1. wget https://download.qt.io/official_releases/qt/5.12/5.12.0/qt-opensource-linux-x64-5.12.0.run
2. chmod +x qt-opensource-linux-x64-5.12.0.run
3. ./qt-opensource-linux-x64-5.12.0.run


./linuxdeployqt-5-x86_64.AppImage ../even-boffin/bin/even-boffin -bundle-non-qt-libs -no-plugins -exclude-libs=libqsqlmysql.so

