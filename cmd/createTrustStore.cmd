@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=..\secret
SET TRUSTSTORE=%SUBDIR%\truststore.jks
SET TRUSTSTORE_PASSWORD=TrustStorePassword
SET CA_NAME=___DO_NOT_TRUST___Valori_workshop_CA
SET CA_CERT_NAME=%SUBDIR%\rootCA.crt

IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)

:: import CA root certificate into truststore
"%KEYTOOL%"^
    -keystore %TRUSTSTORE%^
    -storepass %TRUSTSTORE_PASSWORD%^
    -storetype JKS^
    -importcert^
    -alias %CA_NAME%^
    -file %CA_CERT_NAME%^
    -noprompt