package nl.valori.workshop.e2esecurity.server;

import io.vertx.junit5.VertxExtension;
import io.vertx.junit5.VertxTestContext;
import io.vertx.reactivex.core.Vertx;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

import java.util.concurrent.TimeUnit;

@ExtendWith(VertxExtension.class)
class CertificateHandlerTest {

  @Test
  void testGetCA(final Vertx vertx, final VertxTestContext testContext) throws Throwable {
    final String ca = CertificateHandler.getCA(vertx);

    System.out.println(ca);
    testContext.completeNow();

    Assertions.assertTrue(testContext.awaitCompletion(5_000, TimeUnit.MILLISECONDS));
    if (testContext.failed()) {
      throw testContext.causeOfFailure();
    }
  }
}
