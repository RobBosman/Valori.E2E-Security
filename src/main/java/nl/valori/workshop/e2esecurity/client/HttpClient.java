package nl.valori.workshop.e2esecurity.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

public class HttpClient {

  static String getDataFromServer(final String url) {
    try {
      final HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
      try {
        try (final BufferedReader reader
                 = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
          return reader.lines().collect(Collectors.joining());
        } catch (IOException e) {
          throw new RuntimeException("Error reading from InputStream", e);
        }
      } finally {
        connection.disconnect();
      }
    } catch (MalformedURLException e) {
      throw new RuntimeException("Error in URL " + url, e);
    } catch (IOException e) {
      throw new RuntimeException("Error connecting to " + url, e);
    }
  }
}
