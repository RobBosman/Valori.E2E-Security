package nl.valori.workshop.e2esecurity;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

class HttpClientTest {

  private static final Logger LOG = LoggerFactory.getLogger(HttpClientTest.class);
  private static final String API_URL = "http://api.icndb.com/jokes/random?limitTo=[explicit,nerdy]"; // Chuck Norris jokes

  @Test
  void connectHttpClient() {
    var jokeJson = HttpClient.fetchData(API_URL);
    LOG.debug(jokeJson);
  }
}