package nl.valori.workshop.e2esecurity;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class HttpClientTest {

  private static final String URL_HTTP = "http://valori.example.com:80/";
  private static final String URL_HTTPS = "https://valori.example.com:443/";
  private static final String URL_HTTPS2 = "https://valori.example.com:2443/";

  @BeforeEach
  void setUp() {
    System.setProperty("javax.net.ssl.trustStore", getClass().getResource("/truststore.jks").getPath());
    System.setProperty("javax.net.ssl.trustStorePassword", "TruststorePassword");
    System.setProperty("javax.net.ssl.trustStoreType", "JKS");
  }

  @Test
  void connectHttpClient() {
    final var dataFromServer = HttpClient.getDataFromServer(URL_HTTP);
    assertEquals("Hello there", dataFromServer);
  }

  @Test
  void connectHttpsClient() {
    final var dataFromServer = HttpClient.getDataFromServer(URL_HTTPS);
    assertEquals("Hello there", dataFromServer);
  }

  @Test
  void connectHttps2Client() {
    final var dataFromServer = HttpClient.getDataFromServer(URL_HTTPS2);
    assertEquals("Hello there", dataFromServer);
  }
}