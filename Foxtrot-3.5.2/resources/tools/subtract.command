#!/bin/sh

#---------------------------------------------------
#- Revision: 1.1                                   -
#- Author: R. GIRARDOT                             -
#- Date: December 01 2017                          -
#- Purpose: Launch 2D Operation                    -
#---------------------------------------------------

#--------------------------------
#- 2D operation Root Java Paths -
#--------------------------------
cd `dirname $0`
ROOT_DIR=`pwd`
cd -
cd $ROOT_DIR/../..
TOP_DIR=`pwd`
cd -
JAR_ROOT=$TOP_DIR/lib

#---------------------
#- Test Java version -
#---------------------
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

#--------------------------
#- SOURCE COMMON ENV VARS -
#--------------------------
CLASSPATH=
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.gui-image-subtraction-1.2.2-3627.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.gui-imageoperation-commons-1.2.2-3627.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ch.qos.logback-logback-classic-1.2.3.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-CDMABox-1.0.1-7026.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma-core-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma.plugin-nexus-soleil-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma.plugin-edf-soleil-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-BasicUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeDefinition-2.5.1-5756.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ch.qos.logback-logback-core-1.2.3.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.slf4j-slf4j-api-1.7.25.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-SwingUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeSwing-2.6.4-5814.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeBox-1.2.3-7236.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma-utilities-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CDMADataSource-1.2.2-5719.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/com.famfamfam-silk-1.3.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.tango-project-tango-icon-theme-0.8.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.apache.felix-org.osgi.core-1.4.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.jdom-jdom2-2.0.5.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.cdma.engine-hdf-3.4.5-2250.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/commons-io-commons-io-2.0.1.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-DataConnectionManagement-1.3.2-5816.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-AwtUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/com.miglayout-miglayout-3.7.4.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-SwingXUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-ExpressionAbstraction-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-ExpressionJEval-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib-ImageJUtilities-1.3.6-5812.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/fr.soleil.lib.comete-CometeAWT-2.1.11-5689.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/commons-lang-commons-lang-2.4.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.swinglabs-colorchooser-0.0.1.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.swinglabs-swingx-1.6.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/gov.nih-ij-1.45s.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ncsa.hdf-h5object-2.10.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ncsa.hdf-hdf5lib-2.10.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/ncsa.hdf-object-2.10.0.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.apache.commons-commons-math3-3.5.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/com.jhlabs-filters-2.0.235.jar
CLASSPATH=$CLASSPATH:$JAR_ROOT/org.swinglabs-swing-worker-1.1.jar


#--------------
#- VM Options -
#--------------
JAVA_OPTIONS="-Xms256m -Xmx1024m -Dcom.sun.management.jmxremote=true"


#-------------------
#- USER PARAMETERS -
#-------------------
CDMA_DICTIONARY_ROOT=$TOP_DIR/CDMA
NEXUS_PATH=$TOP_DIR/native/macOSX

#--------------------------
#- Start the 2D operation -
#--------------------------
java $JAVA_OPTIONS -cp $CLASSPATH \
-Djava.library.path=$NEXUS_PATH \
-Duser.language=en \
-Duser.country=US \
-Dlogback.configurationFile=$ROOT_DIR/conf/imageoperation-logback.xml \
-DCDMA_RESOURCES_DIRECTORY=$CDMA_DICTIONARY_ROOT \
fr.soleil.image.subtraction.ImageSubtraction $@
fi
