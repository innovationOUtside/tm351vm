#Monolithic Container Build

FROM psychemedia/testpieces

USER root
RUN apt-get update && apt-get install -y supervisor

RUN mkdir -p /openrefine_projects  && chown oustudent:100 /openrefine_projects
VOLUME /openrefine_projects

RUN mkdir -p /notebooks  && chown oustudent:100 /notebooks
VOLUME /notebooks

RUN mkdir -p /var/log/supervisor
COPY monolithic_container_supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3334
EXPOSE 8888

#Check against settings...
ENV DOCKERBUILD=0

CMD ["/usr/bin/supervisord"]
