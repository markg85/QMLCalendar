# Add more folders to ship with the application, here
folder_01.source = qml/qmlcalendar
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH = /usr/lib/kde4/imports

INCLUDEPATH += /home/mark/kdepimlibs_build/include/
LIBS +=  -L/home/mark/kdepimlibs_build/lib -lakonadi-calendar


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    qmonth.cpp \
    qmonthmodel.cpp \
    qcaleventmodel.cpp \
    utils.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    qmonth.h \
    qmonthmodel.h \
    qcaleventmodel.h \
    utils.h
