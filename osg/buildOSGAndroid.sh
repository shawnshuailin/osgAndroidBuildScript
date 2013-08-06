#!/bin/bash
echo "***********************************************"
echo "OpenSceneGraph OpenGL ES 2.0 build"
echo "***********************************************"
echo "2013. All Rights Reserved. Raphael Grasset"
echo "www.raphaelgrasset.net"
echo "************************************************"
echo "Predefined compilation options:"
echo "OpenGL: ES 2.0"
echo "build mode: release"
echo "build ABI: armeabi armeabi-v7a"
echo "build path: ./build-android-PLATFORMID"
echo "install path ./build-android-PLATFORMID/precompiled"
echo "**********************************"
if [ -z $ANDROID_NDK ]; then
	echo "ERROR: ANDROID_NDK is not defined"
	echo "Please specify your path to your android ndk installation in ANDROID_NDK"
	exit
fi
echo "your Android NDK is in $ANDROID_NDK"
echo "your OSG ROOT is $PWD"
echo "**********************************"
echo "configuration options.."
read -p "Enter the Android NDK API Level/Platform number (8,9,14):" platform_id
echo "android-$platform_id will be used"
unamestr=`uname`
if [ "$unamestr" == 'Linux' ]; then
	cpu_available=`nproc`
elif [ "$unamestr" == 'Darwin' ]; then
	cpu_available=`sysctl -n hw.ncpu`
fi
echo "this host has $cpu_available CPUs available"
read -p "Enter the number of jobs for the compilation (1-8):" jobs_num
echo "$jobs_num will be used.."
read -p "activate neon optimization (y/n):" activate_neon
if [ "$activate_neon" == "y" ]; then
	OSG_NEON_OPTION="-DANDROID_NEON=ON"
	echo "Neon optimization on.."
else
	OSG_NEON_OPTION=""
	echo "Neon optimization off.."
fi
read -p "activate ARM mode optimization (y/n):" activate_arm
if [ "$activate_arm" == "y" ]; then
	OSG_ARM_OPTION="-DANDROID_ARM32=ON"
	echo "ARM mode optimization on.."
else
	OSG_ARM_OPTION=""
	echo "ARM mode optimization off.."
fi
echo "configuration options..OK"
echo "**********************************"
echo "clean before configuration (cmake cache, previous built).."
rm -f CMakeCache.txt
rm -rf build-android-$platform_id
echo "clean before configuration..OK"
echo "**********************************"
echo "cmake configuration..."
mkdir build-android-$platform_id
cd build-android-$platform_id
cmake ../ -DOSG_BUILD_PLATFORM_ANDROID=ON -DCMAKE_BUILD_TYPE=Release -DDYNAMIC_OPENTHREADS=OFF -DDYNAMIC_OPENSCENEGRAPH=OFF -DOSG_CPP_EXCEPTIONS_AVAILABLE=ON -DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF -DOSG_GL_MATRICES_AVAILABLE=OFF -DOSG_GL_VERTEX_FUNCS_AVAILABLE=OFF -DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=OFF -DOSG_GL_FIXED_FUNCTION_AVAILABLE=OFF -DOSG_GL1_AVAILABLE=OFF -DOSG_GL2_AVAILABLE=OFF -DOSG_GL3_AVAILABLE=OFF -DOSG_GLES1_AVAILABLE=OFF -DOSG_GLES2_AVAILABLE=ON -DOSG_GL_LIBRARY_STATIC=OFF -DANDROID_ABI="armeabi armeabi-v7a" -DANDROID_PLATFORM=android-$platform_id $OSG_NEON_OPTION $OSG_ARM_OPTION -DANDROID_STL="gnustl_static" -DJ=$jobs_num -DCMAKE_INSTALL_PREFIX=$PWD/precompiled/
echo "cmake configuration..OK"
echo "**********************************"
echo "build.."
read -p "You want to build now (in $PWD/build) ? (y/n):" build_now
if [ "$build_now" == "y" ]; then
	make
else
	echo "goodbye!"
	echo "**********************************"
	exit
fi
echo "build..OK"
echo "install.."
read -p "You want to install now (in $PWD/precompiled)? (y/n):" install_now
if [ "$install_now" == "y" ]; then
	mkdir precompiled
	make install
else
	echo "goodbye!"
	echo "**********************************"
	exit
fi
echo "install..OK"
echo "cya later"
echo "******************************"
