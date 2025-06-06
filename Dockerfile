# --------------------  Base  --------------------
FROM httpd:2.4

# --------------------  Build args ---------------
# URL del repo y subcarpeta a publicar.
ARG SITE_REPO=https://github.com/learning-zone/website-templates.git
ARG SITE_SUBDIR=sb-admin-2          # el template que quieres servir

# --------------------  Sistema & git -----------
RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# --------------------  Contenido web -----------
RUN rm -rf /usr/local/apache2/htdocs/* \
 # Clonamos sin histórico.
 && git clone --depth 1 "${SITE_REPO}" /tmp/site \
 # Copiamos únicamente la subcarpeta deseada.
 && cp -R "/tmp/site/${SITE_SUBDIR}/." /usr/local/apache2/htdocs/ \
 && chown -R www-data:www-data /usr/local/apache2/htdocs \
 && rm -rf /tmp/site

EXPOSE 80
CMD ["httpd-foreground"]
