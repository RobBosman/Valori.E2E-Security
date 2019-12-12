@ECHO OFF

CALL _config.cmd %*
IF NOT "%TRUSTSTORE_PASSWORD%"=="" (
  SET KEYTOOL=%KEYTOOL% -storepass %TRUSTSTORE_PASSWORD%
)

REM import CA root certificate into truststore
%KEYTOOL% ^
    -keystore "%TRUSTSTORE%" ^
    -storetype JKS ^
    -importcert ^
    -alias "%CA_ALIAS%" ^
    -file %CA_CRT_FILE% ^
    -noprompt
