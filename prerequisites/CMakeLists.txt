cmake_minimum_required(VERSION 2.8)

# LibQtWebApp
project(QtWebApp)

if(WIN32 AND ${CMAKE_SIZEOF_VOID_P} MATCHES 8)
    # Hardcode a location for a QT toolkit compiled for Win64.  By overriding QT_QMAKE, all the rest is found
    # Choose any version of QT found in the 64-bit tools area
    file(GLOB QTROOTS C:/msys64)     # */
    find_program(QT_QMAKE_EXECUTABLE NAMES qmake qmake4 qmake-qt4 qmake-mac PATHS ${QTROOTS})
    find_program(MAKE_EXECUTABLE NAMES mingw32-make.exe PATHS ${QTROOTS})
    set(MKSPEC win32-g++)
    set(FILENAME ${PROJECT_NAME}d1.dll)
    set(BUILDDIR ${CMAKE_CURRENT_BINARY_DIR}/QtWebApp)
    set(DISTDIR ${CMAKE_CURRENT_BINARY_DIR}/../../bin)
endif()
if(UNIX AND ${CMAKE_SIZEOF_VOID_P} MATCHES 8)
    # Hardcode a location for a QT toolkit compiled for Win64.  By overriding QT_QMAKE, all the rest is found
    # Choose any version of QT found in the 64-bit tools area
    set(QT_QMAKE_EXECUTABLE qmake)
    set(MAKE_EXECUTABLE make)
    set(MKSPEC linux-g++-64)
    set(FILENAME lib${PROJECT_NAME}d.so)
    set(BUILDDIR ${CMAKE_CURRENT_BINARY_DIR}/QtWebApp)
    set(DISTDIR ${CMAKE_CURRENT_BINARY_DIR}/../../bin)
endif()
find_package(Qt5 COMPONENTS Core Network)
#/Qt5Config.cmake

set(LIB_FILE ${CMAKE_CURRENT_BINARY_DIR}/QtWebApp/${FILENAME})
set(LIB_HEADER_FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/QtWebApp/QtWebApp)
# how to build the result of the library
set(EXTRA_QMAKE_FLAGS -spec ${MKSPEC} "CONFIG+=debug" "QMAKE_CXXFLAGS+=-fpermissive -Wno-attributes -Wno-unused-parameter -Wno-implicit-fallthrough" "DEFINES+=QT_BUILD_WEBSOCKETS_LIB QT_NO_DEBUG_OUTPUT QT_NO_WARNING_OUTPUT" DESTDIR=${BUILDDIR} OBJECTS_DIR=${BUILDDIR}/.objs MOC_DIR=${BUILDDIR}/.moc RCC_DIR=${BUILDDIR}/.rcc UI_DIR=${BUILDDIR}/.ui)
add_custom_command(OUTPUT  ${LIB_FILE} 
    COMMAND mkdir 
    ARGS -p ${DISTDIR}
    COMMAND ${QT_QMAKE_EXECUTABLE}
    ARGS ${CMAKE_CURRENT_SOURCE_DIR}/QtWebApp/QtWebApp/QtWebApp.pro ${EXTRA_QMAKE_FLAGS}
    COMMAND cd
    ARGS ${CMAKE_CURRENT_SOURCE_DIR}/build
    COMMAND ${MAKE_EXECUTABLE}
    ARGS -j4
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

#string(TOLOWER ${FILENAME} LOW_PROJECT_NAME)
# create a target out of the library compilation result
add_custom_target(${PROJECT_NAME}_target ALL
    COMMAND cp -f ${BUILDDIR}/${FILENAME}* ${DISTDIR}
    DEPENDS ${LIB_FILE})

# create an library target out of the library compilation result
add_library(${PROJECT_NAME} SHARED IMPORTED GLOBAL)
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_target)

# specify where the library is and where to find the headers
set_target_properties(${PROJECT_NAME}
    PROPERTIES
    IMPORTED_LOCATION ${LIB_FILE}
    INTERFACE_INCLUDE_DIRECTORIES ${LIB_HEADER_FOLDER})

