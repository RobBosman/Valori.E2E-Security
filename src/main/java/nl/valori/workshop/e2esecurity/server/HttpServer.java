package nl.valori.workshop.e2esecurity.server;

public class HttpServer extends AbstractHttpServerVerticle {

  static final int PORT = 80;

  @Override
  String getScheme() {
    return "http";
  }

  @Override
  int getPort() {
    return PORT;
  }
}
