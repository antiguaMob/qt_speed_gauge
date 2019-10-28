QT += serialbus  quickwidgets

TARGET = can
TEMPLATE = app

SOURCES += main.cpp \
    cancommunication.cpp

HEADERS += \
    cancommunication.h

RESOURCES += can.qrc \
    qml/main.qml
