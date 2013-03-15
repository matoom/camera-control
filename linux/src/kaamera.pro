#-------------------------------------------------
#
# Project created by QtCreator 2010-08-06T14:41:19
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = kaamera
CONFIG   += console
CONFIG   -= app_bundle
CONFIG	 += staticlib

TEMPLATE = app


SOURCES += main.cpp

HEADERS +=

INCLUDEPATH += D:/qextserialport-1.2/
QMAKE_LIBDIR += D:/qextserialport-1.2/build

LIBS += -LD:/qextserialport-1.2/build \
-lqextserialport

unix:DEFINES = _TTY_POSIX_
win32:DEFINES = _TTY_WIN_ QWT_DLL QT_DLL

OTHER_FILES +=