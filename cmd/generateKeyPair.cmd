@echo off

SET KEYTOOL=%JAVA_HOME%\bin\keytool
SET SUBDIR=certs
SET NAME=%~1
SET KEYSTORE=%SUBDIR%\keystore.p12

IF "%~1"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name>        - generates a private+public key pair in '%KEYSTORE%'
  ECHO.
  EXIT
)

IF NOT EXIST "%SUBDIR%" (
  MKDIR %SUBDIR%
)

:: generate self-signed certificate private key
"%KEYTOOL%"^
    -keystore %KEYSTORE%^
    -storetype PKCS12^
	-genkeypair^
    -alias %NAME%^
    -keyalg RSA^
	-keysize 2048^
    -dname "CN=%NAME%,OU=workshop,O=Valori,L=Utrecht,C=NL"^
    -ext "san=dns:%NAME%,ip:127.0.0.1,ip:::1"
