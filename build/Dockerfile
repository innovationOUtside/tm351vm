#Monolithic Container Build

FROM psychemedia/testpieces

USER root
RUN apt-get update && apt-get install -y supervisor

RUN mkdir -p /notebooks  && chown oustudent:100 /notebooks
VOLUME /notebooks
RUN mkdir -p /var/log/supervisor
COPY monolithic_container_supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8888
CMD ["/usr/bin/supervisord"]
