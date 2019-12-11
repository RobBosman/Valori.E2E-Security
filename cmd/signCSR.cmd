@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=..\secret
SET CA_KEYSTORE=%SUBDIR%\CA-keystore.p12
SET CA_PASSWORD=ValoriWorkshopCAPassword
SET CA_NAME=___DO_NOT_TRUST___Valori_workshop_CA
SET NAME=%~1
SET KEYSTORE=%SUBDIR%\keystore.p12
SET CRS_FILE=%SUBDIR%\%NAME%.csr
SET CRT_FILE=%SUBDIR%\%NAME%.crt


IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)
IF "%~1"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name>  - signs the CSR in '%SUBDIR%\<name>.csr' with %CA_NAME%
  ECHO.
  EXIT
)

:: sign the CSR
"%KEYTOOL%"^
    -keystore %CA_KEYSTORE%^
    -storepass %CA_PASSWORD%^
	-gencert^
    -infile %CRS_FILE%^
    -outfile %CRT_FILE%^
    -alias %CA_NAME%^
    -keyalg RSA^
    -keysize 2048^
    -ext "san=dns:%NAME%,ip:127.0.0.1,ip:::1"
