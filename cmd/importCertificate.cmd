@ECHO OFF

CALL _config.cmd %*
IF NOT "%KEYSTORE_PASSWORD%"=="" (
  SET KEYTOOL=%KEYTOOL% -storepass %KEYSTORE_PASSWORD%
)

IF "%DNAME%"=="" (
  ECHO "Usage: %~n0 <name>
  ECHO "    <name>  - imports the certificate in file '%SECRET_DIR%\<name>.crt' into '%KEYSTORE%'
  ECHO.
) ELSE (
  REM import certificate into the keystore
  %KEYTOOL% ^
      -keystore "%KEYSTORE%" ^
      -importcert ^
      -alias "%DNAME%" ^
      -file "%CRT_FILE%" ^
      -noprompt
)
