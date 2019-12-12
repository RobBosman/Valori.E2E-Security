@ECHO OFF

CALL _config.cmd %*
IF NOT "%CA_PASSWORD%"=="" (
  SET KEYTOOL=%KEYTOOL% -storepass %CA_PASSWORD%
)

REM generate CA root certificate private key
%KEYTOOL% ^
    -keystore "%CA_KEYSTORE%" ^
    -storetype PKCS12 ^
    -genkeypair ^
    -alias "%CA_ALIAS%" ^
    -keyalg RSA ^
    -keysize 2048 ^
    -dname "CN=%CA_DNAME%,OU=workshop,O=Valori,L=Utrecht,C=NL"

REM export CA root certificate
%KEYTOOL% ^
    -keystore "%CA_KEYSTORE%" ^
    -exportcert ^
    -alias "%CA_ALIAS%" ^
    -file %CA_CRT_FILE% ^
    -rfc
