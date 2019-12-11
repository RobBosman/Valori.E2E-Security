@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=..\secret
SET NAME=%~1
SET KEYSTORE=%SUBDIR%\keystore.p12
SET CRS_NAME=%SUBDIR%\%NAME%.csr

IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)

IF "%~1"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name> - generates a CSR of certificate <name> in keystore %KEYSTORE%
  ECHO "             and stores it in %SUBDIR%\<name>.csr
  ECHO.
  EXIT
)

:: create CSR for certificate
"%KEYTOOL%"^
    -keystore %KEYSTORE%^
	-certreq^
    -alias %NAME%^
    -keyalg RSA^
    -keysize 2048^
    -dname "CN=%NAME%,OU=workshop,O=Valori,L=Utrecht,C=NL"^
    -file %CRS_NAME%
