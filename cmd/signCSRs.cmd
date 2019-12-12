@ECHO OFF

CALL _config.cmd %*
IF NOT "%CA_PASSWORD%"=="" (
  SET KEYTOOL=%KEYTOOL% -storepass %CA_PASSWORD%
)
SET INPUT_DIR=%~1

IF "%INPUT_DIR%"=="" (
  ECHO "Usage: %~n0 <inpurDir>
  ECHO "    <inpurDir>  - signs all CSR files located in <inpurDir> with '%CA_DNAME%'
  ECHO "                  and stores the certificates in '%SECRET_DIR%'
  ECHO.
) ELSE (
  REM search all *.csr files in the given input directory and sign them
  FOR %%f IN (%INPUT_DIR%\*.csr) DO (
    REM sign the CSR
    %KEYTOOL% ^
        -keystore "%CA_KEYSTORE%" ^
        -gencert ^
        -infile "%%f" ^
        -outfile "%SECRET_DIR%\%%~nf.crt" ^
        -alias "%CA_ALIAS%" ^
        -keyalg RSA ^
        -keysize 2048 ^
        -ext "san=dns:%%~nf,ip:127.0.0.1,ip:::1"
    ECHO Signed certificate: %SECRET_DIR%\%%~nf.crt
  )
)
