cmake_minimum_required(VERSION 3.23.2)
#set(CMAKE_C_COMPILER "D:/Qt/Tools/mingw810_64/bin/gcc.exe")
#set(CMAKE_CXX_COMPILER "D:/Qt/Tools/mingw810_64/bin/g++.exe")
project(property)
set(QT_VERSION 5)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_PREFIX_PATH "D:/Qt/5.15.2/mingw81_64")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
#set(CMAKE_BUILD_TYPE "Debug")
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
file(GLOB HEAD_FILES ${PROJECT_SOURCE_DIR}/*h)
file(GLOB SRC_FILES ${PROJECT_SOURCE_DIR}/*.cpp)
add_executable(${PROJECT_NAME} WIN32 ${HEAD_FILES} ${SRC_FILES} main.qrc icon.rc)
find_package(Qt${QT_VERSION} COMPONENTS Core Gui Sql Qml Quick QuickControls2 REQUIRED)
target_link_libraries(${PROJECT_NAME} Qt${QT_VERSION}::Core Qt${QT_VERSION}::Gui Qt${QT_VERSION}::Sql Qt${QT_VERSION}::Qml Qt${QT_VERSION}::Quick Qt${QT_VERSION}::QuickControls2)
