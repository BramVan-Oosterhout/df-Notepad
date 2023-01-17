FROM timlegge/docker-foswiki:latest AS base

FROM base AS mytest

COPY nginx.default.conf /etc/nginx/http.d/default.conf

COPY *.tgz /var/www/foswiki/

RUN cd /var/www/foswiki && \
        tar xzf Appnotes.tgz && \
        tar xzf NotepadContrib.tgz NotepadContrib_installer && \
        tar xzf CopyContrib.tgz CopyContrib_installer && \
        tar xzf WikiWorkbenchContrib.tgz WikiWorkbenchContrib_installer && \
        perl WikiWorkbenchContrib_installer -r -o install && \
        perl CopyContrib_installer -r -o install && \
        perl NotepadContrib_installer -r -o install && \
        tools/configure -save -set {HomePagePlugin}{SiteDefaultTopic}='Appnotes' \
                              -set {DefaultUrlHost}='http://localhost:8787' \
                              -set {Password}='insecure'

#CMD ["/bin/sh"]