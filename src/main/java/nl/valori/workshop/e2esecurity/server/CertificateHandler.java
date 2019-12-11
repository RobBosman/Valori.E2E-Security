package nl.valori.workshop.e2esecurity.server;

import io.vertx.core.impl.VertxInternal;
import io.vertx.core.net.JksOptions;
import io.vertx.core.net.TrustOptions;
import io.vertx.core.net.impl.KeyStoreHelper;
import io.vertx.reactivex.core.Vertx;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Base64;

import static nl.valori.workshop.e2esecurity.server.AbstractHttpServerVerticle.SECRET_DIR;

class CertificateHandler {

  private static final Logger LOG = LoggerFactory.getLogger(CertificateHandler.class);

  static String getCA(final Vertx vertx) {
    try {
      return formatCertificate(KeyStoreHelper
          .create(
              (VertxInternal) vertx.getDelegate(),
              (TrustOptions) new JksOptions()
                  .setPath(SECRET_DIR.resolve("truststore.jks").toString())
                  .setPassword("TrustStorePassword"))
          .store()
          .getCertificate("rootCA")
          .getEncoded());
    } catch (Exception e) {
      LOG.error(e.getMessage(), e);
      return "That's a bummer man!";
    }
  }

  private static String formatCertificate(byte[] caCert) {
    return "-----BEGIN CERTIFICATE-----\n"
        + Base64.getEncoder().encodeToString(caCert).replaceAll("(.{64})", "$1\n")
        + "\n-----END CERTIFICATE-----";
  }
}
