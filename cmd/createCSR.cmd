@ECHO OFF

CALL _config.cmd %*
IF NOT "%KEYSTORE_PASSWORD%"=="" (
  SET KEYTOOL=%KEYTOOL% -storepass %KEYSTORE_PASSWORD%
)

IF "%DNAME%"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name> - generates a CSR of certificate <name> in %KEYSTORE%
  ECHO "             and stores it in %SECRET_DIR%\<name>.csr
  ECHO.
) ELSE (
  REM create CSR for certificate
  %KEYTOOL% ^
      -keystore "%KEYSTORE%" ^
      -certreq ^
      -alias "%DNAME%" ^
      -keyalg RSA ^
      -keysize 2048 ^
      -dname "CN=%DNAME%,OU=workshop,O=Valori,L=Utrecht,C=NL" ^
      -file %CRS_FILE%
)
