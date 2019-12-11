package nl.valori.workshop.e2esecurity.server;

import io.vertx.core.VertxOptions;
import io.vertx.reactivex.core.Vertx;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

class Main {

  private static final Logger LOG = LoggerFactory.getLogger(Main.class);

  public static void main(String[] args) {
    final var options = new VertxOptions();
    if (LOG.isDebugEnabled()) {
      options.setBlockedThreadCheckInterval(1000 * 60 * 60);
    }
    final var vertx = Vertx.vertx(options);

    vertx.setTimer(
        1_000 * 60 * 2, // run for 2 minutes
        timerId -> {
          vertx.close();
          LOG.info("And... it's gone!");
        });

    deployVerticle(vertx, HttpServer.class.getName());
    deployVerticle(vertx, HttpsOneWayTlsHttpServer.class.getName());
    deployVerticle(vertx, HttpsTwoWayTlsHttpServer.class.getName());
  }

  private static void deployVerticle(final Vertx vertx, final String verticleClassName) {
    vertx.deployVerticle(
        verticleClassName,
        deployResult -> {
          if (!deployResult.succeeded()) {
            LOG.error("Error deploying {}", verticleClassName, deployResult.cause());
          }
        });
  }
}
