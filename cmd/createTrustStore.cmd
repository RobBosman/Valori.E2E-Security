@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=certs
SET TRUSTSTORE=%SUBDIR%\truststore.jks
SET CA_NAME=%~1
SET CA_CERT_NAME=%SUBDIR%\%CA_NAME%.crt

IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)

IF "%~1"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name>  - imports the certificate in file '<name>.crt' into '%SUBDIR%\truststore.jks'
  ECHO.
  EXIT
)

:: import CA root certificate into truststore
"%KEYTOOL%"^
    -keystore %TRUSTSTORE%^
    -storetype JKS^
    -importcert^
    -alias %CA_NAME%^
    -file %CA_CERT_NAME%^
    -noprompt
