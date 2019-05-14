#!/bin/sh

#---------------------------------------------------
#- Revision: 3.20                                  -
#- Author: R. GIRARDOT / G. VIGUIER                -
#- Date: February 11 2019                          -
#- Purpose: Launch Foxtrot                         -
#---------------------------------------------------
echo "Checking environment..."

#---------------------------------
#- DataReduction Root Java Paths -
#---------------------------------
cd `dirname $0`
ROOT_DIR=`pwd`
cd -
JAR_ROOT=$ROOT_DIR/lib

#---------------------
#- Test Java version -
#---------------------
echo "Checking Java version..."
# Expected Java version
JAVA_VERSION=7
# Installed Java version: since Java 9 -> version.X.Y
JAVA_INSTALLED_VERSION=`java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}'| cut -d'.' -f1`
if [ "$JAVA_INSTALLED_VERSION" = "1" ]
then
# Installed Java version: before Java 9 -> 1.version.X
JAVA_INSTALLED_VERSION=`java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}'| cut -d'.' -f2`
fi
if [ "$JAVA_INSTALLED_VERSION" = "" ]
then
# Java is not even installed
echo "***********************************"
echo "No java installed!"
echo "Please install java JDK (not JRE) $JAVA_VERSION or newer"
echo "***********************************"
elif [ $((JAVA_INSTALLED_VERSION-$JAVA_VERSION)) -lt 0 ]
then
# Too old version of Java
echo "***********************************"
echo "No valid java version found."
echo "You have Java $JAVA_INSTALLED_VERSION installed."
echo "This software needs java JDK (not JRE) $JAVA_VERSION or newer."
echo "***********************************"
else
# Java version OK
echo "Setting up Java..."
#--------------------------
#- SOURCE COMMON ENV VARS -
#--------------------------
CLASSPATH=
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.gui-foxtrot-3.5.2-3650.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.gui-imagereducer-3.5.2-3650.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-DockingVl-1.1.1-5570.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/com.famfamfam-silk-1.3.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.tango-project-tango-icon-theme-0.8.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.swinglabs-colorchooser-0.0.1.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-BasicUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-SwingUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeDefinition-2.5.1-5756.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeSwing-2.6.4-5814.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-NumericalComputing-2.2.0-3647.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.ij.macro-MacroManager-0.1.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.gui-reduction-tools-3.5.2-3650.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.gui-data-export-3.5.2-3650.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-DockingCore-1.1.2-5570.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/commons-collections-commons-collections-3.2.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.apache.commons-commons-math3-3.5.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/com.vlsolutions-vldocking-3.0.2.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-AwtUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/com.miglayout-miglayout-3.7.4.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-DataConnectionManagement-1.3.2-5816.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-SwingXUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-ExpressionAbstraction-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-ExpressionJEval-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-ImageJUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeAWT-2.1.11-5689.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/commons-lang-commons-lang-2.4.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.swinglabs-swingx-1.6.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/gov.nih-ij-1.45s.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.apache.maven-maven-plugin-api-2.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeBox-1.2.3-7236.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma-core-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma.plugin-nexus-soleil-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma.plugin-edf-soleil-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma-utilities-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CDMADataSource-1.2.2-5719.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-CDMABox-1.0.1-7026.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/com.jhlabs-filters-2.0.235.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.swinglabs-swing-worker-1.1.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.apache.felix-org.osgi.core-1.4.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.jdom-jdom2-2.0.5.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma.engine-hdf-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/commons-io-commons-io-2.0.1.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.slf4j-slf4j-simple-1.7.7.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ncsa.hdf-h5object-2.10.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ncsa.hdf-hdf5lib-2.10.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ncsa.hdf-object-2.10.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.slf4j-slf4j-api-1.7.25.jar

#----------------
#- CRASH REPORT -
#----------------
BASE_FILE=$ROOT_DIR/resources/dumps/Foxtrot-$(date +%y%m%d-%H%M%S) 
JVM_DUMP_OPTIONS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$BASE_FILE.hprof -XX:ErrorFile=$BASE_FILE.log"

#----------------------------------
#- USER PARAMETERS and VM Options -
#----------------------------------
JAVA_OPTIONS="-Xms256m -Xmx2048m -Dcom.sun.management.jmxremote=true"
NEXUS_PATH=$ROOT_DIR/native/macOSX
CDMA_DICTIONARY_ROOT=$ROOT_DIR/CDMA
PERSPECTIVEDIRECTORY=$ROOT_DIR/resources/perspective
WORKINGPATH=$HOME
FITDIRECTORY=$ROOT_DIR/resources/fit
FORMULASDIRECTORY=$ROOT_DIR/resources/axisMacro
MASKDIRECTORY=$ROOT_DIR/resources/masks
IMAGEMACRODIRECTORY=$ROOT_DIR/resources/macros
USERMACRODIRECTORY=$ROOT_DIR/resources/userMacros
USERCONTEXTDATADIRECTORY=$ROOT_DIR
EXTERNALWORKERDIRECTORY=$ROOT_DIR/resources/tools
LASTUSEDPATHSFILE=$ROOT_DIR/resources/paths/lastUsedPaths-mac.properties
EXPORTPATH=$HOME
EXTRACTORPATH=$ROOT_DIR/python/extractor.sh
USERGUIDE=$ROOT_DIR/doc/Foxtrot-UserGuide.pdf
# -------------------------------------
# - Calibration highlight color setup -
# -------------------------------------
# CALIBRATION_COLOR represents the highlight color you want to use in detector calibration.
# It is expected to be encoded one of these 2 ways:
# CALIBRATION_COLOR=R,G,B
# or
# CALIBRATION_COLOR=R,G,B,A
# where:
# R,G,B and A are integers between 0 and 255 included.
# R represents red, G green, B blue, and A alpha.
# For alpha, 0 means totally transparent (i.e. invisible) and 255 means totally opaque (i.e. you won't see any pixel color under it).
# If not set, default alpha value will be 120.
# If not set or badly configured, CALIBRATION_COLOR will take the value "0,0,0,120".
# 245,159,200 is pink
CALIBRATION_COLOR=245,159,200,100
# ------------------------------------
# - Nexus files locks cleaning setup -
# ------------------------------------
# NEXUS_ACCESS_CHECK_PERIOD represents at which frequency nexus files locks are checked for their lifetime.
# If not correctly set, NEXUS_ACCESS_CHECK_PERIOD will be set by default to 30 seconds.
# NEXUS_LOCK_LIFETIME represents the lifetime of nexus files locks.
# If a nexus file last access is older than NEXUS_LOCK_LIFETIME, then the associated lock, granted by the OS, will be cleared.
# If not correctly set, NEXUS_LOCK_LIFETIME will be set by default to 2 minutes.
# The 2 properties NEXUS_ACCESS_CHECK_PERIOD and NEXUS_LOCK_LIFETIME follow this logic:
# ValueUnit, where Value is a strictly positive integer, and Unit a time unit.
# Unit can be any of these: milliseconds, seconds, minutes, hours.
# The remaining 's' (for plural) is optional, i.e. Unit can also be millisecond, second, minute, hour.
# Unit is optional. If not set, Value represents milliseconds.
# Examples (1 example per line):
# 40000
# 60000milliseconds
# 20seconds
# 1hour
# 3minutes
NEXUS_ACCESS_CHECK_PERIOD=30seconds
NEXUS_LOCK_LIFETIME=2minutes

#--------------------------------
#- Start Foxtrot                -
#--------------------------------
echo "Launching Foxtrot..."
java $JVM_DUMP_OPTIONS $JAVA_OPTIONS -cp $CLASSPATH \
-Djava.library.path=$NEXUS_PATH \
-Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel \
-DCDMA_RESOURCES_DIRECTORY=$CDMA_DICTIONARY_ROOT \
-DNexusAccessCheckPeriod=$NEXUS_ACCESS_CHECK_PERIOD \
-DNexusLockLifetime=$NEXUS_LOCK_LIFETIME \
fr.soleil.fusion.image.Foxtrot \
WorkingPath=$WORKINGPATH \
ExportPath=$EXPORTPATH \
ExtractorPath=$EXTRACTORPATH \
ImageMacroDirectory=$IMAGEMACRODIRECTORY \
UserMacroDirectory=$USERMACRODIRECTORY \
UserContextDataDirectory=$USERCONTEXTDATADIRECTORY \
MaskDirectory=$MASKDIRECTORY \
PerspectiveDirectory=$PERSPECTIVEDIRECTORY \
FitDirectory=$FITDIRECTORY \
FormulasDirectory=$FORMULASDIRECTORY \
ExternalWorkerDirectory=$EXTERNALWORKERDIRECTORY \
LastUsedPathsFile=$LASTUSEDPATHSFILE \
UserGuide=$USERGUIDE \
ContextModificationInMacrosEnabled=true \
DisplayImageLoading=false \
CalibrationColor=$CALIBRATION_COLOR \
FitEnabled=true \
ColorsEnabled=false \
Language=EN \
InnerRoiForDynamicMacro=true
fi
