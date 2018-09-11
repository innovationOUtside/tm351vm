#Monolithic Container Build

FROM psychemedia/testpieces

USER root
RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY monolithic_container_supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
