osgAndroidBuildScript
=====================

a list of build scripts for OpenSceneGraph and OpenSceneGraph dependencies.


Dependencies
------------
Load dependencies package from http://www.osgvisual.org/projects/osgvisual/wiki/Downloads

copy the content of the osg-dependencies directory to your unzip Dependencies package (e.g. 3rdParty_x86_x64-src_V8b)

export your ANDROID_NDK (e.g. export ANDROID_NDK=PATH_TO_NDK/android-ndkr8)

With the NEON: copy the android_neon to android directory
Without NEON: copy the android_neonoff to android directory

run ./buildOSGDependenciesAndroid.sh

the script will build for platform 8,9,14 a compatible OSG dependency package for Android.
