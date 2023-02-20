

FROM redis 
EXPOSE 6379


CMD /app/rel/web_server/bin/web_server start

# docker build -t web_ocp:v1 .
# crear tag para subir :  docker tag web_ocp:v1  rocha7778/ocp_web:v1.0
# subir imagen: docker push rocha7778/ocp_web:v1.0
# docker create -p 8083:8082 --name webserverv2  web_ocp
# subir imagen a ocp:  oc import-image rocha7778/ocp_web:v1.0 --confirm
#
# docker start webserver
# _build/prod/rel/web_server/bin/web_server start
