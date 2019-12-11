@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=..\secret
SET CA_KEYSTORE=%SUBDIR%\CA-keystore.p12
SET CA_PASSWORD=ValoriWorkshopCAPassword
SET CA_NAME=___DO_NOT_TRUST___Valori_workshop_CA
SET CA_CERT_NAME=%SUBDIR%\rootCA.crt

IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)

:: generate CA root certificate private key
"%KEYTOOL%"^
    -keystore %CA_KEYSTORE%^
    -storepass %CA_PASSWORD%^
    -storetype PKCS12^
    -genkeypair^
    -alias %CA_NAME%^
    -keyalg RSA^
    -keysize 2048^
    -dname "CN=%CA_NAME%,OU=workshop,O=Valori,L=Utrecht,C=NL"

:: export CA root certificate
"%KEYTOOL%"^
    -keystore %CA_KEYSTORE%^
    -storepass %CA_PASSWORD%^
    -exportcert^
    -alias %CA_NAME%^
    -file %CA_CERT_NAME%^
    -rfc