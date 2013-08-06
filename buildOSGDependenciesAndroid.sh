#!/bin/bash

#Compilation script for Android dependencies
#2013. All Rights Reserved. Raphael Grasset. www.raphaelgrasset.net

#script build using:
#osgVisual dependencies package
#Modified Android.mk+other libraries changes from http://www2.ai2.upv.es/difusion/osgAndroid/3rdpartyAndroid.zip

#last update: July 30 2012

#package configurations
ZLIB_PACKAGE=01_zlib-1.2.8
LIBPNG_PACKAGE=02_libpng162
TIFF_PACKAGE=03_tiff-4.0.3
JPEG_PACKAGE=04_jpeg-9
GIFLIB_PACKAGE=05_giflib-4.1.6
#glut
FREETYPE_PACKAGE=07_freetype-2.5.0.1
OPENSSL_PACKAGE=08_openssl-1.0.1e
CURL_PACKAGE=09_curl-7.31.0
GDAL_PACKAGE=10_gdal-1.10.0

LibDepList=( zlib libpng libtiff libjpeg giflib freetype curl gdal )

AndPlatformList=( 8 9 14 )
#for NDKr9 and above
#AndPlatform[2]='android-18'

echo "***********************************************"
echo "OpenSceneGraph OpenGL ES 2.0 build dependencies"
echo "***********************************************"
echo "2013. All Rights Reserved. Raphael Grasset"
echo "www.raphaelgrasset.net"
echo "************************************************"
echo "checking dependencies.."
if [ -z $ANDROID_NDK ]; then
	echo "ERROR: ANDROID_NDK is not defined"
	echo "Please specify your path to your android ndk installation in ANDROID_NDK"
	exit
fi
echo "your Android NDK is in $ANDROID_NDK"
echo "your Dependencies ROOT is $PWD"
echo "checking dependencies..OK"
echo "configuring building.."
unamestr=`uname`
if [ "$unamestr" == 'Linux' ]; then
	cpu_available=`nproc`
elif [ "$unamestr" == 'Darwin' ]; then
	cpu_available=`sysctl -n hw.ncpu`
fi
echo "this host has $cpu_available CPUs available"
read -p "Enter the number of jobs for the compilation (1-n):" jobs_num
echo "$jobs_num will be used.."
rm -rf build-*
mkdir build
cd build
mkdir zlib zlib/include
mkdir libpng libpng/include
mkdir libtiff libtiff/include
mkdir libjpeg libjpeg/include
mkdir giflib giflib/include
mkdir freetype freetype/include
mkdir curl curl/include curl/include/curl
mkdir gdal gdal/include
mkdir build
mkdir build/zlib
mkdir build/libpng
mkdir build/libtiff
mkdir build/libjpeg
mkdir build/giflib
mkdir build/freetype
mkdir build/curl
mkdir build/gdal
cd ..
for i in "${AndPlatformList[@]}"
do 
	echo "building for platform android-$i"
	cp -rf build build-android-$i
done
rm -rf build
cp -f android/zlib/* $ZLIB_PACKAGE/
cp -f android/libpng/* $LIBPNG_PACKAGE/
cp -f android/libtiff/* $TIFF_PACKAGE/
cp -f $JPEG_PACKAGE/jmorecfg.h $JPEG_PACKAGE/jmorecfg.h.bak
cp -f android/libjpeg/* $JPEG_PACKAGE/
cp -f android/giflib/* $GIFLIB_PACKAGE/
cp -f $FREETYPE_PACKAGE/include/freetype/config/ftoption.h $FREETYPE_PACKAGE/include/freetype/config/ftoption.h.bak
cp -f android/freetype/* $FREETYPE_PACKAGE/
cp -f android/openssl/* $OPENSSL_PACKAGE/
cp -f android/curl/* $CURL_PACKAGE/
cp -f $GDAL_PACKAGE/config.sub $GDAL_PACKAGE/config.sub.bak
cp -f android/gdal/* $GDAL_PACKAGE/
echo "configuring building..OK"
echo "start to build.."
echo "building zlib package.."
cd $ZLIB_PACKAGE
rm -rf obj
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./
	cp -rf obj ../build-android-$i/build/zlib
	mv -f obj ../build-android-$i/zlib/
	cp -f zlib.h zconf.h ../build-android-$i/zlib/include/
	cp -f zlib.h zconf.h ../build-android-$i/zlib/
done
echo "building zlib package..OK"
echo "building libpng package.."
cd ..
cd $LIBPNG_PACKAGE
rm -rf obj
cp -f ../$ZLIB_PACKAGE/zconf.h .
cp -f ../$ZLIB_PACKAGE/zlib.h .
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./ -j $jobs_num
	cp -rf obj ../build-android-$i/build/libpng
	mv -f obj ../build-android-$i/libpng/
	cp -f png.h pngconf.h pnglibconf.h ../build-android-$i/libpng/include/
	cp -f png.h pngconf.h pnglibconf.h ../build-android-$i/libpng/
done
rm -f zconf.h zlib.h
rm pnglibconf.h
echo "building libpng package..OK"
echo "building libtiff package.."
cd ..
cd $TIFF_PACKAGE
rm -rf obj
mv -f tif_config.h libtiff/tif_config.h
mv -f tiffconf.h libtiff/tiffconf.h
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./ -j $jobs_num
	cp -rf obj ../build-android-$i/build/libtiff
	mv -f obj/ ../build-android-$i/libtiff/
	cp libtiff/tiff.h libtiff/tiffconf.h libtiff/tiffio.h libtiff/tiffvers.h ../build-android-$i/libtiff/include/
	cp libtiff/tiff.h libtiff/tiffconf.h libtiff/tiffio.h libtiff/tiffvers.h ../build-android-$i/libtiff/
done
rm -f libtiff/tif_config.h libtiff/tiffconf.h
echo "building libtiff package..OK"
echo "building libjpeg package.."
cd ..
cd $JPEG_PACKAGE
rm -rf obj
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./ -j $jobs_num
	cp -rf obj ../build-android-$i/build/libjpeg
	mv -f obj ../build-android-$i/libjpeg/
	cp jpeglib.h jconfig.h jerror.h jmorecfg.h ../build-android-$i/libjpeg/include/
	cp jpeglib.h jconfig.h jerror.h jmorecfg.h ../build-android-$i/libjpeg/
done
rm -f jconfig.h
mv -f jmorecfg.h.bak jmorecfg.h

echo "building libjpeg package..OK"
echo "building giflib package.."
cd ..
cd $GIFLIB_PACKAGE
rm -rf obj
cp -f config.h lib/config.h
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./ -j $jobs_num
	cp -rf obj ../build-android-$i/build/giflib
	mv -f obj ../build-android-$i/giflib/
	cp lib/gif_lib.h ../build-android-$i/giflib/include
	cp lib/gif_lib.h ../build-android-$i/giflib/
done
rm -f lib/config.h
echo "building giflib package..OK"
echo "building freetype package.."
cd ..
cd $FREETYPE_PACKAGE
rm -rf obj
cp -f ftoption.h include/freetype/config/ftoption.h
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./ -j $jobs_num
	cp -rf obj ../build-android-$i/build/freetype
	mv -f obj ../build-android-$i/freetype/
	cp -r include/* ../build-android-$i/freetype/include
	cp -r include/* ../build-android-$i/freetype/
done
rm -f ftoption.h
mv -f include/freetype/config/ftoption.h.bak include/freetype/config/ftoption.h
echo "building freetype package..OK"
echo "building openssl package.."
cd ..
cd $OPENSSL_PACKAGE
rm -rf obj
for i in "${AndPlatformList[@]}"
do 
    echo "NO CONFIG YET"
done
echo "building openssl package..OK"
echo "building curl package.."
cd ..
cd $CURL_PACKAGE
rm -rf obj
cp -f curl_config.h src/curl_config.h
mv -f curl_config.h lib/curl_config.h
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./ -j $jobs_num
	cp -rf obj ../build-android-$i/build/curl
	mv -f obj ../build-android-$i/curl/
	cp -f include/curl/*.h ../build-android-$i/curl/include/curl
	cp -f include/curl/*.h ../build-android-$i/curl/include/
done
rm -f src/curl_config.h lib/curl_config.h
echo "building curl package..OK"
echo "building gdal package.."
cd ..
cd $GDAL_PACKAGE
rm -rf obj
mv -f cpl_config.h port/
for i in "${AndPlatformList[@]}"
do 
	$ANDROID_NDK/ndk-build NDK_APPLICATION_MK=Application-$i.mk NDK_PROJECT_PATH=./ -j $jobs_num
	cp -rf obj ../build-android-$i/build/gdal
	mv -f obj ../build-android-$i/gdal/
	cp -f gcore/*.h ../build-android-$i/gdal/include
	cp -f alg/*.h ../build-android-$i/gdal/include
	cp -f port/*.h ../build-android-$i/gdal/include
	cp -f ogr/*.h ../build-android-$i/gdal/include
	cp -f frmts/mem/memdataset.h ../build-android-$i/gdal/include
	cp -f frmts/raw/rawdataset.h ../build-android-$i/gdal/include
	cp -f frmts/vrt/vrtdataset.h ../build-android-$i/gdal/include
	cp -f frmts/vrt/gdal_vrt.h ../build-android-$i/gdal/include
	cp -f ogr/ogrsf_frmts/ogr_attrind.h ../build-android-$i/gdal/include
	cp -f ogr/ogrsf_frmts/ogrsf_frmts.h ../build-android-$i/gdal/include	
done
rm port/cpl_config.h
mv config.sub.bak config.sub
echo "building gdal package..OK"
cd ..
for i in "${AndPlatformList[@]}"
do 
	for j in "${LibDepList[@]}"
	do
		cp android/$j/Android.mk build-android-$i/$j/
		rm -rf build-android-$i/$j/obj/local/armeabi/objs 
		rm -rf build-android-$i/$j/obj/local/armeabi-v7a/objs
		rm -rf build-android-$i/build/$j/obj/local/armeabi/objs 
		rm -rf build-android-$i/build/$j/obj/local/armeabi-v7a/objs
	done
done



