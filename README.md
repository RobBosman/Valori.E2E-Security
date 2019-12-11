# E2E Security
### about secure (encrypted) data transport

This repo contains Java code to demonstrate:
* key features of secure data transport (TLS, certificates)
* connecting to secured servers via HTTPS with one- and two-sided TLS

[Here](https://slides.com/robbosman/e2e-security/) is the presentation that goes along with the code.

### preparation
This is what I did to set-up the development environment:
1) install [Java JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html) version 8 or higher
1) install a Java IDE, e.g. [IntelliJ IDEA](https://www.jetbrains.com/idea/) (Community Edition) or [Eclipse](https://www.eclipse.org/downloads/)
1) (optional) install [Fiddler](https://www.telerik.com/download/fiddler/) for monitoring network traffic

## Workshop

### 1. browse to http://valori.example.com/
> This won't work, because `example.com` is a non-existing domain, see [wikipedia](https://en.wikipedia.org/wiki/Example.com).\
> However, you can fool your computer by adding the following line to the `hosts` file:
>
> ```#.#.#.# valori.example.com```
> 
> where `#.#.#.#` is the IP number of the test server.\
> The `hosts` file can be found here:
> * Windows: `%SystemRoot%\System32\drivers\etc\hosts`
> * MacOS, Linux: `/etc/hosts`

### 2. browse to https://valori.example.com/
> This won't work because the server certificate is not valid.

### 3. import the CA root certificate
> Copy the root certificate listed on [http://valori.example.com/ca](http://valori.example.com/ca) and store it in a file called `rootCA.crt`.\
> Double-click this file and import the certificate in the trust store of your **_Local Computer_** under "_Trusted root Certificate Authorities_" ("_Vertrouwde basiscertificeringsinstanties_"").

### 4. browse to https://valori.example.com/
> Check if the server certificate is valid.

### 5. browse to https://valori.example.com:2443/
> This probably won't work because you did not present a client certificate.

### 6. generate a certificate private key
> See `cmd\generateKeyPair.cmd`.
>
### 7. create a Certificate Signing Request (CSR)
> See `cmd\createCSR.cmd`.

### 8. have the CSR signed by the Certificate Authority

### 9. install the signed certificate in your browser
