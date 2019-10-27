QT += serialbus widgets qml quick quickwidgets

TARGET = can
TEMPLATE = app

SOURCES += main.cpp \
    cancommunication.cpp

HEADERS += \
    cancommunication.h

RESOURCES += can.qrc \
    qml/main.qml
