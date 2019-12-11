package nl.valori.workshop.e2esecurity.server;

import io.vertx.core.Future;
import io.vertx.core.http.HttpServerOptions;
import io.vertx.reactivex.core.AbstractVerticle;
import io.vertx.reactivex.core.net.SocketAddress;
import io.vertx.reactivex.ext.web.Router;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.file.Path;
import java.nio.file.Paths;

abstract class AbstractHttpServerVerticle extends AbstractVerticle {

  private static final Logger LOG = LoggerFactory.getLogger(AbstractHttpServerVerticle.class);
  static final String HOST_NAME = "valori.example.com";
  static final Path SECRET_DIR = Paths.get(System.getProperty("user.dir"), "secret");

  @Override
  public void start(final Future<Void> future) {
    final Router router = Router.router(vertx);

    router.get("/rootCA.crt")
        .handler(routingContext ->
            routingContext.response()
                .putHeader("content-type", "text/plain")
                .end(CertificateHandler.getCA(vertx)));

    router.route("/")
        .handler(routingContext ->
            routingContext.response()
                .putHeader("content-type", "text/html")
                .end("<h1>Hello there!</h1>" +
                    "<p>Click <a href='rootCA.crt'>here</a> to see the CA root certificate.</p>"));

    vertx.createHttpServer(createServerOptions())
        .requestHandler(router)
        .listen(
            SocketAddress.inetSocketAddress(getPort(), HOST_NAME),
            result -> {
              if (result.succeeded()) {
                LOG.info("Listening on {}://{}:{}/", getScheme(), HOST_NAME, getPort());
              }
              future.handle(result.mapEmpty());
            });
  }

  HttpServerOptions createServerOptions() {
    return new HttpServerOptions();
  }

  abstract String getScheme();

  abstract int getPort();
}
