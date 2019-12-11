package nl.valori.workshop.e2esecurity.server;

import io.vertx.junit5.VertxExtension;
import io.vertx.junit5.VertxTestContext;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.ext.web.client.WebClient;
import io.vertx.reactivex.ext.web.codec.BodyCodec;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

import java.util.concurrent.TimeUnit;

import static nl.valori.workshop.e2esecurity.server.AbstractHttpServerVerticle.HOST_NAME;

@ExtendWith(VertxExtension.class)
class HttpsServerTest {

  private AbstractHttpServerVerticle server;

  @BeforeEach
  void setUp(final Vertx vertx, final VertxTestContext testContext) {
    server = new HttpServer();
    vertx.deployVerticle(server, testContext.completing());
  }

  @Test
  void testServer(final Vertx vertx, final VertxTestContext testContext) throws Throwable {
    WebClient.create(vertx)
        .get(server.getPort(), HOST_NAME, "/")
        .as(BodyCodec.string())
        .send(testContext.succeeding(response ->
            testContext.verify(() -> {
              Assertions.assertTrue(response.body().contains("Hello there!"));
              testContext.completeNow();
            })));

    Assertions.assertTrue(testContext.awaitCompletion(5_000, TimeUnit.MILLISECONDS));
    if (testContext.failed()) {
      throw testContext.causeOfFailure();
    }
  }
}
