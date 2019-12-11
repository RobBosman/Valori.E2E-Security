# E2E Security

This repo contains Java code to demonstrate:
* key features of secure data transport (TLS, certificates)
* connecting to secured servers via HTTPS with one and two way TLS

[Here](https://slides.com/robbosman/e2e-security/) is the presentation that goes along with the code.

---
---
## Workshop - part A

### preparation
* install [Java JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html) version 8 or higher

### 1. browse to http://valori.example.com/
>This won't work, because `example.com` is a non-existing domain, see [wikipedia](https://en.wikipedia.org/wiki/Example.com).\
>However, you can fool your computer by adding the following line to the `hosts` file:
>
>```#.#.#.# valori.example.com```
>
>where `#.#.#.#` is the IP number of the test server.\
>The `hosts` file can be found here:
>* Windows: `%SystemRoot%\System32\drivers\etc\hosts`
>* MacOS, Linux: `/etc/hosts`

### 2. browse to https://valori.example.com/
>This won't work because the server certificate is not valid!

### 3. install the CA root certificate
>Copy the root certificate listed on [http://valori.example.com/rootCA.crt](http://valori.example.com/rootCA.crt)
>and store it in a file called `rootCA.crt`.\
>Double-click this file to open a dialog with an _Install Certificate..._ button
>and install the certificate in the trust store of your **_Local Computer_**
>under "_Trusted Root Certificate Authorities_" ("_Vertrouwde basiscertificeringsinstanties_"").

### 4. browse to https://valori.example.com/
 Check if the server certificate is valid.

### 5. browse to https://valori.example.com:2443/
>This probably won't work because you did not present a client certificate.

### 6. generate a certificate private key
> Fill-in a nice `<name>` and password here:
>```
>keytool
>   -keystore keystore.p12
>   -storetype PKCS12
>   -genkeypair
>   -alias <name>
>   -keyalg RSA
>   -keysize 2048
>   -dname "CN=<name>,OU=workshop,O=Valori,L=Utrecht,C=NL"
>   -ext "san=dns:<name>"
>```
> The `keytool` executable is located in the `bin` directory of the Java JDK.\
> Don't forget the password you entered!
>
### 7. create a Certificate Signing Request (CSR)
> Use the same `<name>` here:
>```
>keytool
>   -keystore keystore.p12
>   -certreq
>   -alias <name>
>   -keyalg RSA
>   -keysize 2048
>   -dname "CN=<name>,OU=workshop,O=Valori,L=Utrecht,C=NL"
>   -file <name>.csr
>```

### 8. have the CSR signed by the Certificate Authority
> Send the csr file to your Certificate Authority.

### 9. import both the CA root certificate and the signed certificate into your keystore
>```
>keytool
>   -keystore keystore.p12
>   -importcert
>   -alias <name>
>   -file <name>.crt
>   -noprompt
>```
> You can use `rootCA` here to import the CA root certificate.

### 10. install your private key (in keystore.p12) in your browser
>Go to the *Settings* of your browser, click *Advanced* and open *Maintain Certificates*.\
>Import the file `keystore.p12` into the *Personal* certificate store of your browser.

### 11. browse to https://valori.example.com:2443/ once more
>...and present your newly created and signed certificate to the server.

---
---
## Workshop - part B

### preparation
* install [Java JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html) version 8 or higher
* install a Java IDE, e.g. [IntelliJ IDEA](https://www.jetbrains.com/idea/) (Community Edition) or [Eclipse](https://www.eclipse.org/downloads/)
* (optional) install [Fiddler](https://www.telerik.com/download/fiddler/) for monitoring network traffic

### 1. open your Java IDE and create a new project
> based on Git repository https://github.com/RobBosman/valori.E2E-Security.git

### 2. run unit test `HttpClientTest`
>Fix any failing unit tests!\
>Hint: just like your browser in part A of this workshop, the Java code needs access to the right certificates.

### 3. create a truststore with the root CA certificate
>```
>keytool
>   -keystore truststore.jks
>   -storetype JKS
>   -importcert
>   -alias rootCA
>   -file rootCA.crt
>   -noprompt
>```
>Don't forget the password you entered!

### 4. configure the Java code to use truststore.jks
>add these lines to class `HttpClientTest`:
>```
>System.setProperty("javax.net.ssl.trustStore", "<absolute path to truststore.jks>");
>System.setProperty("javax.net.ssl.trustStorePassword", "<TrustStorePassword>");
>System.setProperty("javax.net.ssl.trustStoreType", "JKS");
>```

### 5. run unit test `HttpClientTest`
>and see what happens

### 6. configure the Java code to use keystore.p12
>add these lines to class `HttpClientTest`:
>```
>System.setProperty("javax.net.ssl.keyStore", "<absolute path to keystore.p12");
>System.setProperty("javax.net.ssl.keyStorePassword", "<KeyStorePassword>");
>System.setProperty("javax.net.ssl.keyStoreType", "PKCS12");
>```

### 7. run unit test `HttpClientTest`
>and have a beer!
