@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=..\secret
SET TRUSTSTORE=%SUBDIR%\truststore.jks
SET NAME=%~1
SET KEYSTORE=%SUBDIR%\keystore.p12
SET CERT_NAME=%SUBDIR%\%NAME%.crt

IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)

IF "%~1"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name>  - imports the certificate in file <name>.crt into '%SUBDIR%\keystore.p12'
  ECHO.
  EXIT
)

:: import certificate into the keystore
"%KEYTOOL%"^
    -keystore %KEYSTORE%^
    -importcert^
    -alias %NAME%^
    -file %CERT_NAME%^
    -noprompt
