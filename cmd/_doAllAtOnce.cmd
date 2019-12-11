@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=..\secret

SET CA_KEYSTORE=%SUBDIR%\CA-keystore.p12
SET CA_PASSWORD=ValoriWorkshopCAPassword
SET CA_NAME=___DO_NOT_TRUST___Valori_workshop_CA
SET CA_ALIAS=rootCA
SET CA_CERT_NAME=%SUBDIR%\%CA_ALIAS%.crt
SET TRUSTSTORE=%SUBDIR%\truststore.jks
SET TRUSTSTORE_PASSWORD=TrustStorePassword

SET NAME=valori.example.com
SET KEYSTORE=%SUBDIR%\keystore.p12
SET KEYSTORE_PASSWORD=KeyStorePassword
SET CRS_NAME=%SUBDIR%\%NAME%.csr
SET CERT_NAME=%SUBDIR%\%NAME%.crt

IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)


REM generate CA root certificate private key
"%KEYTOOL%" ^
    -keystore %CA_KEYSTORE% ^
    -storepass %CA_PASSWORD% ^
    -storetype PKCS12 ^
    -alias %CA_ALIAS%^
    -genkeypair ^
    -keyalg RSA ^
    -keysize 2048 ^
    -dname "CN=%CA_NAME%,OU=workshop,O=Valori,L=Utrecht,C=NL"
REM export CA root certificate
"%KEYTOOL%" ^
    -keystore %CA_KEYSTORE% ^
    -storepass %CA_PASSWORD% ^
    -alias %CA_ALIAS%^
    -exportcert ^
    -rfc ^
    -file %CA_CERT_NAME%
REM import CA root certificate into truststore
"%KEYTOOL%" ^
    -keystore %TRUSTSTORE% ^
    -storepass %TRUSTSTORE_PASSWORD% ^
    -storetype JKS ^
    -alias %CA_ALIAS%^
    -importcert ^
    -file %CA_CERT_NAME% ^
    -noprompt


REM generate self-signed certificate private key
"%KEYTOOL%" ^
    -keystore %KEYSTORE% ^
    -storepass %KEYSTORE_PASSWORD% ^
    -storetype PKCS12 ^
    -alias %NAME%^
    -genkeypair ^
    -keyalg RSA ^
    -keysize 2048 ^
    -dname "CN=%NAME%,OU=workshop,O=Valori,L=Utrecht,C=NL" ^
    -ext "san=dns:%NAME%,ip:127.0.0.1,ip:::1"
REM create CSR for certificate
"%KEYTOOL%" ^
    -keystore %KEYSTORE% ^
    -storepass %KEYSTORE_PASSWORD% ^
    -alias %NAME% ^
    -certreq ^
    -keyalg RSA ^
    -keysize 2048 ^
    -dname "CN=%NAME%,OU=workshop,O=Valori,L=Utrecht,C=NL" ^
    -file %CRS_NAME%
REM sign the CSR
"%KEYTOOL%" ^
    -keystore %CA_KEYSTORE% ^
    -storepass %CA_PASSWORD% ^
    -alias %CA_ALIAS% ^
    -gencert ^
    -keyalg RSA ^
    -keysize 2048 ^
    -infile %CRS_NAME% ^
    -outfile %CERT_NAME% ^
    -ext "san=dns:%NAME%,ip:127.0.0.1,ip:::1"
REM import CA root certificate into the keystore
"%KEYTOOL%" ^
    -keystore %KEYSTORE% ^
    -storepass %KEYSTORE_PASSWORD% ^
    -alias %CA_ALIAS% ^
    -importcert ^
    -file %CA_CERT_NAME% ^
    -noprompt
REM import signed certificate into the keystore
"%KEYTOOL%" ^
    -keystore %KEYSTORE% ^
    -storepass %KEYSTORE_PASSWORD% ^
    -alias %NAME% ^
    -importcert ^
    -file %CERT_NAME% ^
    -noprompt
REM export the signed certificate
"%KEYTOOL%" ^
    -keystore %KEYSTORE% ^
    -storepass %KEYSTORE_PASSWORD% ^
    -alias %NAME% ^
    -exportcert ^
    -rfc ^
    -file %CERT_NAME%
