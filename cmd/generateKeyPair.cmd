@ECHO OFF

CALL _config.cmd %*
IF NOT "%KEYSTORE_PASSWORD%"=="" (
  SET KEYTOOL=%KEYTOOL% -storepass %KEYSTORE_PASSWORD%
)

IF "%DNAME%"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name>        - generates a private + public key pair in '%KEYSTORE%'
  ECHO.
) ELSE (
  REM generate self-signed certificate and private key
  %KEYTOOL% ^
      -keystore "%KEYSTORE%" ^
      -storetype PKCS12 ^
      -genkeypair ^
      -alias "%DNAME%" ^
      -keyalg RSA ^
      -keysize 2048 ^
      -dname "CN=%DNAME%,OU=workshop,O=Valori,L=Utrecht,C=NL" ^
      -ext "san=dns:%DNAME%,ip:127.0.0.1,ip:::1"
)
