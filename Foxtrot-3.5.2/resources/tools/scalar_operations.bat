@ECHO OFF
GOTO SCRIPT_BEGIN
REM --------------------------------------------------
REM - Revision: 1.1                                  -
REM - Author: R. GIRARDOT                            -
REM - Date: November 29 2017                         -
REM - Purpose: Launch 2D Operation                   -
REM --------------------------------------------------
:SCRIPT_BEGIN
setlocal enableDelayedExpansion 

REM ----------------
REM - Java version -
REM ----------------
SET JAVA_VERSION=7

REM -----------------------
REM - 2D operation stuffs -
REM -----------------------
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
SET TOP_DIR=%ROOT_DIR:~0,-15%
SET JAR_ROOT=%TOP_DIR%\lib

REM ---------------------
REM - JAVA VM OPTIONS   -
REM ---------------------
set JAVA_OPTIONS=-Xms256m -Xmx1024m

REM --------------------------------
REM - Test Java 32/64 bits version -
REM --------------------------------
SET JAVA_COMMAND=java
SET J64=false
for /f "tokens=3" %%g in ('java -version 2^>^&1 ^') do (
  if /i "%%g" == "64-Bit" set J64=true
)
if %J64%==true GOTO J64
GOTO J32

:J64
SET NATIVE_DIR=%TOP_DIR%\native\win64
SET PATH_DIR=%TOP_DIR%\native\path64
GOTO CLASSPATH

:J32
SET NATIVE_DIR=%TOP_DIR%\native\win32
SET PATH_DIR=%TOP_DIR%\native\path32
GOTO CLASSPATH

:CLASSPATH
REM -----------------------------------------------------
REM - Test java version in case of default java command -
REM -----------------------------------------------------
for /f tokens^=1-5^ delims^=^"^.^-^_ %%g in ('java -fullversion 2^>^&1') do (
  REM %%g contains "java full version"
  REM %%h contains searched version for java >= 9
  REM %%i contains searched version for java <= 8
  if %%h GEQ %JAVA_VERSION% GOTO JAVA_OK
  if %%h == 1 (
    if %%i GEQ %JAVA_VERSION% GOTO JAVA_OK
  )
  GOTO NO_JAVA
)
:JAVA_OK
REM ---------------------
REM - Setting CLASSPATH -
REM ---------------------
SET CLASSPATH="%NATIVE_DIR%"\*
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.gui-image-linear-function-1.2.2-3627.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.gui-imageoperation-commons-1.2.2-3627.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ch.qos.logback-logback-classic-1.2.3.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-CDMABox-1.0.1-7026.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma-core-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma.plugin-nexus-soleil-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma.plugin-edf-soleil-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-BasicUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeDefinition-2.5.1-5756.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ch.qos.logback-logback-core-1.2.3.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.slf4j-slf4j-api-1.7.25.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-SwingUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeSwing-2.6.4-5814.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeBox-1.2.3-7236.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma-utilities-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CDMADataSource-1.2.2-5719.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\com.famfamfam-silk-1.3.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.tango-project-tango-icon-theme-0.8.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.apache.felix-org.osgi.core-1.4.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.jdom-jdom2-2.0.5.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.cdma.engine-hdf-3.4.5-2250.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\commons-io-commons-io-2.0.1.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-DataConnectionManagement-1.3.2-5816.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-AwtUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\com.miglayout-miglayout-3.7.4.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-SwingXUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-ExpressionAbstraction-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-ExpressionJEval-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib-ImageJUtilities-1.3.6-5812.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\fr.soleil.lib.comete-CometeAWT-2.1.11-5689.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\commons-lang-commons-lang-2.4.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.swinglabs-colorchooser-0.0.1.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.swinglabs-swingx-1.6.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\gov.nih-ij-1.45s.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ncsa.hdf-h5object-2.10.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ncsa.hdf-hdf5lib-2.10.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\ncsa.hdf-object-2.10.0.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.apache.commons-commons-math3-3.5.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\com.jhlabs-filters-2.0.235.jar"
SET CLASSPATH=%CLASSPATH%;"%JAR_ROOT%\org.swinglabs-swing-worker-1.1.jar"

SET PATH=%PATH_DIR%;%PATH%

REM -------------------
REM - User Parameters -
REM -------------------
SET CDMA_DICTIONARY_ROOT="%TOP_DIR%\CDMA"

REM ------------------------
REM - Start '2D operation' -
REM ------------------------
%JAVA_COMMAND% ^
-Djava.library.path="%NATIVE_DIR%" ^
-Duser.language=en ^
-Duser.country=US ^
-Dlogback.configurationFile=%ROOT_DIR%\conf\imageoperation-logback.xml ^
-DCDMA_RESOURCES_DIRECTORY=%CDMA_DICTIONARY_ROOT% ^
%JAVA_OPTIONS% ^
-cp %CLASSPATH% ^
fr.soleil.image.linear.ImageLinearFunction %*
GOTO END

:NO_JAVA
@ECHO **********************************************
@ECHO No valid Java detected.
@ECHO Please install Java %JAVA_VERSION% or greater!
@ECHO **********************************************
PAUSE
GOTO END

:END
