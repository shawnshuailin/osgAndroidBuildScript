osgAndroidBuildScript
=====================

a list of build scripts for OpenSceneGraph (OSG) and OpenSceneGraph dependencies.


Dependencies
------------
Load the most recent osg dependencies package from osgvisual from http://www.osgvisual.org/projects/osgvisual/wiki/Downloads

unzip the package.

copy the content of the osg-dependencies directory to your unzipped Dependencies package (e.g. 3rdParty_x86_x64-src_V8b)

export your ANDROID_NDK (e.g. export ANDROID_NDK=PATH_TO_NDK/android-ndkr8)

With NEON: move the android_neon to an android directory
Without NEON: move the android_neonoff to an android directory

run ./buildOSGDependenciesAndroid.sh

the script will build for platform 8,9,14 using selected NDK version, and build a compatible OSG dependency package for Android.

libs: curl, freetype, gdal, giflib, libjpeg, libpng, libtiff, zlib.

Note 1: all build profiles use gnustl_static, exceptions and rtti, build for ARM (not thumb), armeabi and armeabi-v7a.

Note 2: libpng use the built zlib (see the script).

Note 3: gdal build is only loading few drivers.

OSG
------------
