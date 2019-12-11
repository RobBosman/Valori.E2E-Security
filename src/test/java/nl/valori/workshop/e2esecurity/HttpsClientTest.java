package nl.valori.workshop.e2esecurity;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.nio.file.Path;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.assertTrue;

class HttpsClientTest {

  private static final String URL_HTTP = "http://valori.example.com:80/";
  private static final String URL_HTTPS = "https://valori.example.com:443/";
  private static final String URL_HTTPS2 = "https://valori.example.com:2443/";
  private static final Path SECRET_DIR = Paths.get(System.getProperty("user.dir"), "secret");

  @BeforeAll
  static void setUp() {
    System.setProperty("javax.net.ssl.trustStore", SECRET_DIR.resolve("truststore.jks").toString());
    System.setProperty("javax.net.ssl.trustStorePassword", "TrustStorePassword");
    System.setProperty("javax.net.ssl.trustStoreType", "JKS");
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