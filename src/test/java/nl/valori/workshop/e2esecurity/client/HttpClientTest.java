package nl.valori.workshop.e2esecurity.client;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

class HttpClientTest {

  private static final String URL_HTTP = "http://valori.example.com:80/";
  private static final String URL_HTTPS = "https://valori.example.com:443/";
  private static final String URL_HTTPS2 = "https://valori.example.com:2443/";

  @Test
  void connectHttpClient() {
    final String dataFromServer = HttpClient.getDataFromServer(URL_HTTP);
    assertTrue(dataFromServer.contains("Hello there!"));
  }

  @Test
  void connectHttpsClient() {
    final String dataFromServer = HttpClient.getDataFromServer(URL_HTTPS);
    assertTrue(dataFromServer.contains("Hello there!"));
  }

  @Test
  void connectHttps2Client() {
    final String dataFromServer = HttpClient.getDataFromServer(URL_HTTPS2);
    assertTrue(dataFromServer.contains("Hello there!"));
  }
}
