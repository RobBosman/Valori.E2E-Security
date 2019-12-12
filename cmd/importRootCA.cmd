@ECHO OFF

CALL _config.cmd %*
IF NOT "%KEYSTORE_PASSWORD%"=="" (
  SET KEYTOOL=%KEYTOOL% -storepass %KEYSTORE_PASSWORD%
)

REM import CA root certificate into the keystore
%KEYTOOL% ^
    -keystore "%KEYSTORE%" ^
    -alias "%CA_ALIAS%" ^
    -importcert ^
    -file %CA_CRT_FILE% ^
    -noprompt
