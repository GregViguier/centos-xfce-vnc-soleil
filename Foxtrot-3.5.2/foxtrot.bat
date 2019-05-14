@ECHO OFF
GOTO SCRIPT_BEGIN
REM ---------------------------------------------------
REM - Revision: 3.20                                  -
REM - Author: R. GIRARDOT/ G. Viguier                 -
REM - Date: February 11 2019                          -
REM - Purpose: Launch Foxtrot                         -
REM ---------------------------------------------------
:SCRIPT_BEGIN
@ECHO Checking environment...
setlocal enableDelayedExpansion 

REM ----------------
REM - Java version -
REM ----------------
SET JAVA_VERSION=7

REM ------------------------
REM - DataReduction stuffs -
REM ------------------------
SET ROOT_DIR=%~dp0
REM Find DOS name
SET TMP_DIR=""
for /d %%I in ("%ROOT_DIR%") do (
  if %TMP_DIR% == "" (
    SET TMP_DIR=%%~sI
  ) else (
    SET TMP_DIR=%TMP_DIR%%%~sI
  )
)
SET ROOT_DIR=%TMP_DIR%
REM Remove last "\"
if "%ROOT_DIR:~-1%" == "\" (
  SET ROOT_DIR=%ROOT_DIR:~0,-1%
)
SET JAR_ROOT=%ROOT_DIR%\lib

REM --------------------------------
REM - Test Java 32/64 bits version -
REM --------------------------------
@ECHO Checking Java version...
SET JAVA_COMMAND=javaw
SET J64=false
for /f "tokens=3" %%g in ('java -version 2^>^&1 ^') do (
  if /i "%%g" == "64-Bit" set J64=true
)
if %J64%==true GOTO J64
GOTO J32

:J64
SET JAVA_OPTIONS=-Xms256m -Xmx2048m
SET NATIVE_DIR=%ROOT_DIR%\native\win64
SET PATH_DIR=%ROOT_DIR%\native\path64
GOTO JAVA_TEST

:J32
SET JAVA_OPTIONS=-Xms256m -Xmx1024m
SET NATIVE_DIR=%ROOT_DIR%\native\win32
SET PATH_DIR=%ROOT_DIR%\native\path32
GOTO JAVA_TEST

:JAVA_TEST
REM -----------------------------------------------------
REM - Test java version in case of default java command -
REM -----------------------------------------------------
for /f tokens^=1-5^ delims^=^"^.^-^_ %%g in ('java -fullversion 2^>^&1') do (
  REM %%g contains "java full version"
  REM %%h contains searched version for java >= 9
  REM %%i contains searched version for java <= 8
  if %%h GEQ %JAVA_VERSION% GOTO CLASSPATH
  if %%h == 1 (
    if %%i GEQ %JAVA_VERSION% GOTO CLASSPATH
  )
  GOTO NO_JAVA
)
@ECHO Setting up Java...
:CLASSPATH
REM ---------------------
REM - Setting CLASSPATH -
REM ---------------------
SET CLASSPATH="%NATIVE_DIR%"\*
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.gui-foxtrot-3.5.2-3650.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.gui-imagereducer-3.5.2-3650.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-DockingVl-1.1.1-5570.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\com.famfamfam-silk-1.3.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.tango-project-tango-icon-theme-0.8.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.swinglabs-colorchooser-0.0.1.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-BasicUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-SwingUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeDefinition-2.5.1-5756.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeSwing-2.6.4-5814.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-NumericalComputing-2.2.0-3647.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.ij.macro-MacroManager-0.1.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.gui-reduction-tools-3.5.2-3650.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.gui-data-export-3.5.2-3650.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-DockingCore-1.1.2-5570.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\commons-collections-commons-collections-3.2.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.apache.commons-commons-math3-3.5.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\com.vlsolutions-vldocking-3.0.2.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-AwtUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\com.miglayout-miglayout-3.7.4.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-DataConnectionManagement-1.3.2-5816.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-SwingXUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-ExpressionAbstraction-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-ExpressionJEval-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-ImageJUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeAWT-2.1.11-5689.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\commons-lang-commons-lang-2.4.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.swinglabs-swingx-1.6.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\gov.nih-ij-1.45s.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.apache.maven-maven-plugin-api-2.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeBox-1.2.3-7236.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma-core-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma.plugin-nexus-soleil-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma.plugin-edf-soleil-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma-utilities-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CDMADataSource-1.2.2-5719.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-CDMABox-1.0.1-7026.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\com.jhlabs-filters-2.0.235.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.swinglabs-swing-worker-1.1.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.apache.felix-org.osgi.core-1.4.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.jdom-jdom2-2.0.5.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma.engine-hdf-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\commons-io-commons-io-2.0.1.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.slf4j-slf4j-simple-1.7.7.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ncsa.hdf-h5object-2.10.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ncsa.hdf-hdf5lib-2.10.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ncsa.hdf-object-2.10.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.slf4j-slf4j-api-1.7.25.jar"

SET PATH=%PATH_DIR%;%PATH%

REM ------------------------
REM - Setting DUMP OPTIONS -
REM ------------------------
for /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set NOW=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%-%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%

SET BASE_FILE=%ROOT_DIR%/resources/dumps/Foxtrot-%NOW%
SET JVM_DUMP_OPTIONS=-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=%BASE_FILE%.hprof -XX:ErrorFile=%BASE_FILE%.log

REM -------------------
REM - User Parameters -
REM -------------------
SET CDMA_DICTIONARY_ROOT="%ROOT_DIR%\CDMA"
SET PERSPECTIVEDIRECTORY="%ROOT_DIR%\resources\Perspective"
SET FITDIRECTORY="%ROOT_DIR%\resources\fit"
SET FORMULASDIRECTORY="%ROOT_DIR%\resources\axisMacro"
SET MASKDIRECTORY="%ROOT_DIR%\resources\masks"
SET IMAGEMACRODIRECTORY="%ROOT_DIR%\resources\macros"
SET USERMACRODIRECTORY="%ROOT_DIR%\resources\userMacros"
SET USERCONTEXTDATADIRECTORY="%ROOTDIR%"
SET EXTERNALWORKERDIRECTORY="%ROOT_DIR%\resources\tools"
SET LASTUSEDPATHSFILE="%ROOT_DIR%\resources\paths\lastUsedPaths-windows.properties"
SET EXTRACTORPATH="%ROOT_DIR%\python\extractor.bat"
SET WORKINGPATH=C:
SET EXPORTPATH=C:
SET USERGUIDE="%ROOT_DIR%\doc\Foxtrot-UserGuide.pdf"
REM -------------------------------------
REM - Calibration highlight color setup -
REM -------------------------------------
REM CALIBRATION_COLOR represents the highlight color you want to use in detector calibration.
REM It is expected to be encoded one of these 2 ways:
REM CALIBRATION_COLOR=R,G,B
REM or
REM CALIBRATION_COLOR=R,G,B,A
REM where:
REM R,G,B and A are integers between 0 and 255 included.
REM R represents red, G green, B blue, and A alpha.
REM For alpha, 0 means totally transparent (i.e. invisible) and 255 means totally opaque (i.e. you won't see any pixel color under it).
REM If not set, default alpha value will be 120.
REM If not set or badly configured, CALIBRATION_COLOR will take the value "0,0,0,120".
REM 245,159,200 is pink
SET CALIBRATION_COLOR=245,159,200,100
REM ------------------------------------
REM - Nexus files locks cleaning setup -
REM ------------------------------------
REM NEXUS_ACCESS_CHECK_PERIOD represents at which frequency nexus files locks are checked for their lifetime.
REM If not correctly set, NEXUS_ACCESS_CHECK_PERIOD will be set by default to 30 seconds.
REM NEXUS_LOCK_LIFETIME represents the lifetime of nexus files locks.
REM If a nexus file last access is older than NEXUS_LOCK_LIFETIME, then the associated lock, granted by the OS, will be cleared.
REM If not correctly set, NEXUS_LOCK_LIFETIME will be set by default to 2 minutes.
REM The 2 properties NEXUS_ACCESS_CHECK_PERIOD and NEXUS_LOCK_LIFETIME follow this logic:
REM ValueUnit, where Value is a strictly positive integer, and Unit a time unit.
REM Unit can be any of these: milliseconds, seconds, minutes, hours.
REM The remaining 's' (for plural) is optional, i.e. Unit can also be millisecond, second, minute, hour.
REM Unit is optional. If not set, Value represents milliseconds.
REM Examples (1 example per line):
REM 40000
REM 60000milliseconds
REM 20seconds
REM 1hour
REM 3minutes
SET NEXUS_ACCESS_CHECK_PERIOD=30seconds
SET NEXUS_LOCK_LIFETIME=2minutes

REM --------------------------------
REM - Start 'Foxtrot'              -
REM --------------------------------
@ECHO Launching Foxtrot...
START "Foxtrot" %JAVA_COMMAND% ^
-Djava.library.path="%NATIVE_DIR%" ^
%JVM_DUMP_OPTIONS% ^
-DCDMA_RESOURCES_DIRECTORY=%CDMA_DICTIONARY_ROOT% ^
-DNexusAccessCheckPeriod=%NEXUS_ACCESS_CHECK_PERIOD% ^
-DNexusLockLifetime=%NEXUS_LOCK_LIFETIME% ^
%JAVA_OPTIONS% ^
-cp %CLASSPATH% ^
fr.soleil.fusion.image.Foxtrot ^
WorkingPath=%WORKINGPATH% ^
ExportPath=%EXPORTPATH% ^
ExtractorPath=%EXTRACTORPATH% ^
ImageMacroDirectory=%IMAGEMACRODIRECTORY% ^
UserMacroDirectory=%USERMACRODIRECTORY% ^
UserContextDataDirectory=%USERCONTEXTDATADIRECTORY% ^
MaskDirectory=%MASKDIRECTORY% ^
PerspectiveDirectory=%PERSPECTIVEDIRECTORY% ^
FitDirectory=%FITDIRECTORY% ^
FormulasDirectory=%FORMULASDIRECTORY% ^
ExternalWorkerDirectory=%EXTERNALWORKERDIRECTORY% ^
LastUsedPathsFile=%LASTUSEDPATHSFILE% ^
UserGuide=%USERGUIDE% ^
ContextModificationInMacrosEnabled=true ^
DisplayImageLoading=false ^
CalibrationColor=%CALIBRATION_COLOR% ^
FitEnabled=true ^
ColorsEnabled=false ^
Language=EN ^
InnerRoiForDynamicMacro=true
GOTO END

:NO_JAVA
@ECHO **********************************************
@ECHO No valid Java detected.
@ECHO Please install Java %JAVA_VERSION% or greater!
@ECHO **********************************************
PAUSE
GOTO END

:END
