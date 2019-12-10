package nl.valori.workshop.e2esecurity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

class HttpClientTest {

  private static final String URL_HTTP = "http://valori.example.com:80/";
  private static final String URL_HTTPS = "https://valori.example.com:443/";
  private static final String URL_HTTPS2 = "https://valori.example.com:2443/";

  @BeforeEach
  void setUp() {
    final String userDir = System.getProperty("user.dir");

    System.setProperty("javax.net.ssl.trustStore", userDir + "/private/truststore.jks");
    System.setProperty("javax.net.ssl.trustStorePassword", "TrustStorePassword");
    System.setProperty("javax.net.ssl.trustStoreType", "JKS");

    System.setProperty("javax.net.ssl.keyStore", userDir + "/private/keystore.p12");
    System.setProperty("javax.net.ssl.keyStorePassword", "KeyStorePassword");
    System.setProperty("javax.net.ssl.keyStoreType", "PKCS12");
  }

  @Test
  void connectHttpClient() {
    final var dataFromServer = HttpClient.getDataFromServer(URL_HTTP);
    assertTrue(dataFromServer.contains("Hello there!"));
  }

  @Test
  void connectHttpsClient() {
    final var dataFromServer = HttpClient.getDataFromServer(URL_HTTPS);
    assertTrue(dataFromServer.contains("Hello there!"));
  }

  @Test
  void connectHttps2Client() {
    final var dataFromServer = HttpClient.getDataFromServer(URL_HTTPS2);
    assertTrue(dataFromServer.contains("Hello there!"));
  }
}