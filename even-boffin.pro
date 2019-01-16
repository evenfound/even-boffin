TARGET = even-boffin
TEMPLATE = app
QT += core network
#CONFIG += console

INCLUDEPATH += ./include \
    $$PWD/prerequisites/even-cpp/common/include/core \
    $$PWD/prerequisites/even-cpp/common/include/web \
    $$PWD/prerequisites/QtWebApp/QtWebApp \
    $$PWD/prerequisites/QtWebApp/QtWebApp/templateengine \
    $$PWD/prerequisites/QtWebApp/QtWebApp/qtwebsockets/src/websockets


# Directory where the debug version of the shared library (*.dll or *.so) is stored, and base name of the file.
CONFIG(debug, debug|release) {
    win32:      LIBS += -L$$PWD/bin/ -lQtWebAppd1
    mac:        LIBS += -L$$PWD/bin/ -lQtWebAppd_debug
    unix:!mac:  LIBS += -L$$PWD/bin/ -lQtWebAppd
}

win32 {
   DEFINES += QTWEBAPPLIB_IMPORT
}

SOURCES += ./src/main.cpp \
            ./src/Node.cxx \
            ./src/NodeNetwork.cxx\
            ./src/Network.cxx\
            ./src\BoffinApp.cxx \
            ./prerequisites/even-cpp/common/src/core/Value.cxx\
            ./prerequisites/even-cpp/common/src/core/Controller.cxx \
            ./prerequisites/even-cpp/common/src/core/Config.cxx \
            ./prerequisites/even-cpp/common/src/core/Application.cxx \
            ./prerequisites/even-cpp/common/src/core/SignalHandler.cxx \
            ./prerequisites/even-cpp/common/src/core/Logger.cxx \
            ./prerequisites/even-cpp/common/src/core/Message.cxx \
            ./prerequisites/even-cpp/common/src/core/FileConfig.cxx \
            ./prerequisites/even-cpp/common/src/web/RequestHandler.cxx \
            ./prerequisites/even-cpp/common/src/web/TemplateHolder.cxx \
            ./prerequisites/even-cpp/common/src/web/WebServer.cxx \
            ./prerequisites/even-cpp/common/src/core/Storage.cxx \
            ./prerequisites/even-cpp/common/src/core/Wallet.cxx \
            ./prerequisites/even-cpp/common/src/core/Transaction.cxx \
            ./prerequisites/even-cpp/common/src/core/Account.cxx \
            ./prerequisites/even-cpp/common/src/core/Hash.cxx \
            ./prerequisites/even-cpp/common/src/core/TransactionTree.cxx \
            ./prerequisites/even-cpp/common/src/web/TemplateController.cxx \
            ./prerequisites/even-cpp/common/src/web/SessionController.cxx \
            ./prerequisites/even-cpp/common/src/core/Exposition.cxx


HEADERS += ./include/Node.hxx \
            ./include/NodeNetwork.hxx\
            ./include/Network.hxx\
            ./include/BoffinApp.hxx \
            ./prerequisites/even-cpp/common/include/core/Value.hxx \
            ./prerequisites/even-cpp/common/include/core/Controller.hxx \
            ./prerequisites/even-cpp/common/include/core/Config.hxx \
            ./prerequisites/even-cpp/common/include/core/Core.hxx \
            ./prerequisites/even-cpp/common/include/core/Defines.hxx \
            ./prerequisites/even-cpp/common/include/core/Logger.hxx \
            ./prerequisites/even-cpp/common/include/core/Message.hxx \
            ./prerequisites/even-cpp/common/include/core/Application.hxx \
            ./prerequisites/even-cpp/common/include/core/FileConfig.hxx \
            ./prerequisites/even-cpp/common/include/core/CallOnce.hxx \
            ./prerequisites/even-cpp/common/include/core/Singleton.hxx \
            ./prerequisites/even-cpp/common/include/core/SignalHandler.hxx \
            ./prerequisites/even-cpp/common/include/web/RequestHandler.hxx \
            ./prerequisites/even-cpp/common/include/web/TemplateHolder.hxx \
            ./prerequisites/even-cpp/common/include/web/WebServer.hxx \
            ./prerequisites/even-cpp/common/include/core/Storage.hxx \
            ./prerequisites/even-cpp/common/include/core/Wallet.hxx \
            ./prerequisites/even-cpp/common/include/core/Transaction.hxx \
            ./prerequisites/even-cpp/common/include/core/Account.hxx \
            ./prerequisites/even-cpp/common/include/core/Hash.hxx \
            ./prerequisites/even-cpp/common/include/core/TransactionTree.hxx \
            ./prerequisites/even-cpp/common/include/core/Random.hxx \
            ./prerequisites/even-cpp/common/include/web/TemplateController.hxx \
            ./prerequisites/even-cpp/common/include/web/SessionController.hxx \
            ./prerequisites/even-cpp/common/include/core/Exposition.hxx
