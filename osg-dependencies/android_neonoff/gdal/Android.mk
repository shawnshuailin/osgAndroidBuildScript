LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libgdal

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := false
endif

ALG_SOURCES := gdal_rpc.cpp gdal_tps.cpp \
		thinplatespline.cpp llrasterize.cpp gdalrasterize.cpp gdalgeoloc.cpp \
		gdalgrid.cpp gdalcutline.cpp gdalproximity.cpp rasterfill.cpp \
		gdalrasterpolygonenumerator.cpp \
		gdalsievefilter.cpp polygonize.cpp \
		gdalrasterfpolygonenumerator.cpp fpolygonize.cpp \
		contour.cpp gdaltransformgeolocs.cpp \
		gdal_octave.cpp gdal_simplesurf.cpp gdalmatching.cpp \
		gdalmediancut.cpp gdaldither.cpp gdal_crs.c gdaltransformer.cpp \
		gdalsimplewarp.cpp gdalwarper.cpp gdalwarpkernel.cpp \
		gdalwarpoperation.cpp gdalchecksum.cpp 
#		gdalwarpkernel_opencl.cpp

GCORE_SOURCES :=  gdaldrivermanager.cpp \
		gdalopeninfo.cpp gdaldriver.cpp gdaldataset.cpp \
		gdalrasterband.cpp gdal_misc.cpp rasterio.cpp gdalrasterblock.cpp \
		gdalcolortable.cpp gdalmajorobject.cpp overview.cpp \
		gdaldefaultoverviews.cpp gdalpamdataset.cpp gdalpamrasterband.cpp \
		gdaljp2metadata.cpp gdaljp2box.cpp gdalmultidomainmetadata.cpp \
		gdal_rat.cpp gdalgmlcoverage.cpp gdalpamproxydb.cpp \
		gdalallvalidmaskband.cpp gdalnodatamaskband.cpp gdal_rpcimdio.cpp \
 		gdalproxydataset.cpp gdalproxypool.cpp gdaldefaultasync.cpp \
		gdalnodatavaluesmaskband.cpp gdaldllmain.cpp gdalexif.cpp gdalclientserver.cpp

PORT_SOURCES := cpl_conv.cpp cpl_error.cpp cpl_string.cpp cplgetsymbol.cpp cplstringlist.cpp \
	cpl_strtod.cpp cpl_path.cpp cpl_csv.cpp cpl_findfile.cpp cpl_minixml.cpp \
	cpl_multiproc.cpp cpl_list.cpp cpl_getexecpath.cpp cplstring.cpp \
	cpl_vsil_win32.cpp cpl_vsisimple.cpp cpl_vsil.cpp cpl_vsi_mem.cpp \
	cpl_vsil_unix_stdio_64.cpp cpl_http.cpp cpl_hash_set.cpp cplkeywordparser.cpp \
	cpl_recode.cpp cpl_recode_iconv.cpp cpl_recode_stub.cpp cpl_quad_tree.cpp \
	cpl_atomic_ops.cpp cpl_vsil_subfile.cpp cpl_time.cpp \
	cpl_vsil_stdout.cpp cpl_vsil_sparsefile.cpp cpl_vsil_abstract_archive.cpp \
	cpl_vsil_tar.cpp cpl_vsil_stdin.cpp cpl_vsil_buffered_reader.cpp \
	cpl_base64.cpp cpl_vsil_curl.cpp cpl_vsil_curl_streaming.cpp \
	cpl_vsil_cache.cpp cpl_xml_validate.cpp cpl_spawn.cpp \
	cpl_google_oauth2.cpp cpl_progress.cpp
	
OGR_SOURCES := ogrspatialreference.cpp ogrgeometryfactory.cpp ogrpoint.cpp ogrcurve.cpp ogrlinestring.cpp ogrlinearring.cpp \
ogrpolygon.cpp ogrutils.cpp ogrgeometry.cpp ogrgeometrycollection.cpp ogrmultipolygon.cpp \
ogrsurface.cpp ogrmultipoint.cpp ogrmultilinestring.cpp ogrfeature.cpp ogrfeaturedefn.cpp \
ogrfeaturequery.cpp ogrfeaturestyle.cpp ogrfielddefn.cpp \
ogr_srsnode.cpp ogr_srs_proj4.cpp ogr_fromepsg.cpp ogrct.cpp ogr_opt.cpp \
ogr_srs_esri.cpp ogr_srs_pci.cpp ogr_srs_usgs.cpp ogr_srs_dict.cpp \
ogr_srs_panorama.cpp ogr_srs_ozi.cpp ogr_srs_erm.cpp swq.cpp \
swq_expr_node.cpp swq_parser.cpp swq_select.cpp swq_op_registrar.cpp \
swq_op_general.cpp  ogr_srs_validate.cpp ogr_srs_xml.cpp ograssemblepolygon.cpp \
ogr2gmlgeometry.cpp  gml2ogrgeometry.cpp ogr_expat.cpp ogrpgeogeometry.cpp ogrgeomediageometry.cpp \
ogr_geocoding.cpp

OGR_DRIVER_SOURCES:= \
gxf/gxfdataset.cpp gxf/gxfopen.c gxf/gxf_proj4.c gxf/gxf_ogcwkt.c \
hfa/hfaopen.cpp hfa/hfaentry.cpp hfa/hfadictionary.cpp hfa/hfafield.cpp hfa/hfatype.cpp \
hfa/hfaband.cpp hfa/hfacompress.cpp hfa/hfadataset.cpp hfa/hfa_overviews.cpp \
gtiff/libgeotiff/xtiff.c gtiff/libgeotiff/geo_free.c gtiff/libgeotiff/geo_get.c \
gtiff/libgeotiff/geo_names.c gtiff/libgeotiff/geo_new.c gtiff/libgeotiff/geo_print.c \
gtiff/libgeotiff/geo_set.c gtiff/libgeotiff/geo_tiffp.c gtiff/libgeotiff/geo_write.c \
gtiff/libgeotiff/geo_normalize.c gtiff/libgeotiff/geotiff_proj4.c gtiff/libgeotiff/geo_extra.c \
gtiff/libgeotiff/geo_trans.c gtiff/libgeotiff/geo_simpletags.c \
gtiff/geotiff.cpp gtiff/gt_wkt_srs.cpp gtiff/gt_citation.cpp gtiff/gt_overview.cpp \
gtiff/tif_float.c gtiff/tifvsi.cpp gtiff/gt_jpeg_copy.cpp 

FRMTS_SOURCES := gdalallregister.cpp $(OGR_DRIVER_SOURCES)

OGRSFFRMTS_SOURCES := generic/ogrsfdriverregistrar.cpp

#####

LOCAL_SRC_FILES := $(addprefix frmts/,$(FRMTS_SOURCES)) $(addprefix gcore/,$(GCORE_SOURCES)) $(addprefix port/,$(PORT_SOURCES)) $(addprefix alg/,$(ALG_SOURCES)) $(addprefix ogr/ogrsf_frmts/,$(OGRSFFRMTS_SOURCES)) $(addprefix ogr/,$(OGR_SOURCES))

#ALG_CFLAGS := -DHAVE_GEOS=1 $(GEOS_CFLAGS)
#-Wall -Wdeclaration-after-statement
LOCAL_CFLAGS := -DOGR_ENABLED -DFRMT_gxf -DFRMT_gtiff -DFRMT_hfa
#-DFRMT_aigrid -DFRMT_aaigrid -DFRMT_ceos -DFRMT_ceos2 -DFRMT_iso8211 -DFRMT_xpm -DFRMT_sdts -DFRMT_raw -DFRMT_dted -DFRMT_mem -DFRMT_jdem -DFRMT_envisat -DFRMT_elas -DFRMT_fit -DFRMT_vrt -DFRMT_usgsdem -DFRMT_l1b -DFRMT_nitf -DFRMT_bmp -DFRMT_pcidsk -DFRMT_airsar -DFRMT_rs2 -DFRMT_ilwis -DFRMT_rmf -DFRMT_leveller -DFRMT_sgi -DFRMT_srtmhgt -DFRMT_idrisi -DFRMT_gsg -DFRMT_ingr -DFRMT_ers -DFRMT_jaxapalsar -DFRMT_dimap -DFRMT_gff -DFRMT_cosar -DFRMT_pds -DFRMT_adrg -DFRMT_coasp -DFRMT_tsx -DFRMT_terragen -DFRMT_blx -DFRMT_msgn -DFRMT_til -DFRMT_r -DFRMT_northwood -DFRMT_saga -DFRMT_xyz -DFRMT_hf2 -DFRMT_kmlsuperoverlay -DFRMT_ctg -DFRMT_e00grid -DFRMT_zmap -DFRMT_ngsgeoid -DFRMT_iris -DFRMT_map -DFRMT_bsb -DFRMT_gif -DFRMT_jpeg -DFRMT_png -DFRMT_pcraster -DFRMT_rik -DFRMT_ozi -DFRMT_pdf -DFRMT_arg "-DGDAL_FORMATS=gxf gtiff hfa aigrid aaigrid ceos ceos2 iso8211 xpm sdts raw dted mem jdem envisat elas fit vrt usgsdem l1b nitf bmp pcidsk airsar rs2 ilwis rmf leveller sgi srtmhgt idrisi gsg ingr ers jaxapalsar dimap gff cosar pds adrg coasp tsx terragen blx msgn til r northwood saga xyz hf2 kmlsuperoverlay ctg e00grid zmap ngsgeoid iris map bsb gif jpeg png pcraster  rik ozi pdf arg"

DRIVERS_INCLUDES :=  $(LOCAL_PATH)/ogr/ogrsf_frmts/mem $(LOCAL_PATH)/frmts/gtiff $(LOCAL_PATH)/frmts/gtiff/libgeotiff/ $(LOCAL_PATH)/frmts/gtiff/libtiff/

LOCAL_C_INCLUDES :=  $(LOCAL_PATH) $(LOCAL_PATH)/port/ $(LOCAL_PATH)/gcore/  $(LOCAL_PATH)/alg/  $(LOCAL_PATH)/ogr $(LOCAL_PATH)/ogr/ogrsf_frmts $(DRIVERS_INCLUDES)

include $(BUILD_STATIC_LIBRARY)

#curl, LibXML2

#SQLite, Expat XML Parser (KML, GPX, GeoRSS (and GML if no Xerces C++)), LIBXML2, iconv
#Geos
#Java

#not supported:
#GDAL/OGR PostgreSQL support, INGRES, MySQL, HDF4, HDF5, NetCDF, DODS, JPEG2000 (Kadaku, Jasper, Open-JPEG), MrSID/Mg4 (Lidar SDK), ECW, Xerces (GML, Ili), Google Lib KML (OGR KML driver), NAS format, Oracle, GRASS, SDE, FileGFB, ArcObjects, PCIDSK, DWGdirect, Informix DataBlade, FMEObjects, PCRaster, DDS via Crunch Support, Rasdaman, Poppler, Podofo, freexl, Armadillo

#LIBS	=	$(SDE_LIB)  -lz  -lm -ldl -lsupc++ -lstdc++ 

#include ./ogr/file.lst
#GDAL_OBJ += $(addprefix ./ogr/,$(OBJ))

#GDAL_ROOT	
#HAVE_OGDI = no
#OGR_ENABLED = yes
# libtool targets and help variables
#LIBGDAL	:=		libgdal.la
#LIBGDAL_CURRENT	:=	18
#LIBGDAL_REVISION	:=	0
#LIBGDAL_AGE	:=	17

# native build targets and variables
#GDAL_VER	=	1.10.0

# version info
#GDAL_VERSION_MAJOR =    1
#GDAL_VERSION_MINOR =    10
#GDAL_VERSION_REV   =    0

#
# SQLite 
#
#SQLITE_INC = 
#SQLITE_HAS_COLUMN_METADATA = 
#HAVE_SQLITE = no
#HAVE_SPATIALITE = no
#SPATIALITE_INC = 
#SPATIALITE_AMALGAMATION = no
#HAVE_PCRE = no

#
# JPEG-2000 Support via JasPer library.
#
#HAVE_JASPER     = no
#JASPER_FLAGS	= 

# PCRaster support
#PCRASTER_SETTING	=	internal
#
#OGDI_INCLUDE	=	
#
#PNG_SETTING     =	internal
#JPEG_SETTING	=	internal
#JPEG12_ENABLED =	yes
#TIFF_JPEG12_ENABLED =    yes
#TIFF_SETTING	=	internal
#TIFF_OPTS	=	-DBIGTIFF_SUPPORT
#RENAME_INTERNAL_LIBTIFF_SYMBOLS = no
#GEOTIFF_SETTING	=	internal
#GEOTIFF_INCLUDE =	
#RENAME_INTERNAL_LIBGEOTIFF_SYMBOLS = no
#GIF_SETTING	=	internal
#FITS_SETTING    =       no
#OGDI_SETTING	=	no
#ODBC_SETTING    =       no
## PGeo driver is built-in when ODBC is available
#PGEO_SETTING    =       no
#MSSQLSPATIAL_SETTING    =       no
#GEOMEDIA_SETTING    =       no
#NETCDF_SETTING  =       no
#LIBZ_SETTING	=	external
#LIBLZMA_SETTING	=	no
#
##
## CharLs stuff
## Uncomment and adapt paths to enable JPEGLS driver
##
##HAVE_CHARLS = yes
##CHARLS_INC = -I/path/to/charls_include
##CHARLS_LIB = -L/path/to/charls_lib -lCharLS
#
##
## PROJ.4 stuff
##
#PROJ_STATIC	=	no
#ifeq ($(PROJ_STATIC),yes)
#PROJ_FLAGS = -DPROJ_STATIC
#endif
#PROJ_INCLUDE	=	
#
#PAM_SETTING     =       -DPAM_ENABLED
#
#ifeq ($(OGR_ENABLED),yes)
#GDAL_LIBS	:= $(GDAL_LIB) $(OCI_LIB) $(GDAL_LIBS)
#CPPFLAGS	:= -DOGR_ENABLED $(CPPFLAGS)
#else
#GDAL_LIBS	=	$(GDAL_LIB)
#endif
#
#
##
##	Note these codes have to exactly match the format directory names, 
##	and their uppercase form should be the format portion of the
##	format registration entry point.  eg. gdb -> GDALRegister_GDB().
##
#GDAL_FORMATS = 	gxf gtiff hfa aigrid aaigrid ceos ceos2 iso8211 xpm \
#		sdts raw dted mem jdem envisat elas fit vrt usgsdem l1b \
#		nitf bmp pcidsk airsar rs2 ilwis rmf leveller sgi srtmhgt \
#		idrisi gsg ingr ers jaxapalsar dimap gff cosar pds adrg \
#		coasp tsx terragen blx msgn til r northwood saga xyz hf2 \
#		kmlsuperoverlay ctg e00grid zmap ngsgeoid iris map\
#		bsb gif jpeg png pcraster 
#
#
#ifneq ($(LIBZ_SETTING),no)
#GDAL_FORMATS := $(GDAL_FORMATS) rik ozi pdf
#endif
#
#ifeq ($(OGR_ENABLED),yes)
#ifeq ($(HAVE_SQLITE),yes)
#GDAL_FORMATS := $(GDAL_FORMATS) rasterlite mbtiles
#endif
#endif
#
#ifeq ($(HAVE_POSTGISRASTER),yes)
#GDAL_FORMATS := $(GDAL_FORMATS) postgisraster
#endif
#
#ifeq ($(HAVE_CHARLS),yes)
#GDAL_FORMATS := $(GDAL_FORMATS) jpegls
#endif
#
#ifeq ($(OGR_ENABLED),yes)
#GDAL_FORMATS := $(GDAL_FORMATS) arg
#endif

