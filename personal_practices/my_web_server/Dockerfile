

FROM elixir as build_image
ENV MIX_ENV=prod
WORKDIR /app
RUN  mix local.hex --force && mix local.rebar --force
COPY mix.exs mix.lock ./
RUN mix deps.get && mix deps.compile
COPY . .
RUN mix release


FROM elixir 
ENV MIX_ENV=prod
WORKDIR /app
EXPOSE 8082 8080
COPY --from=build_image /app/_build/prod/  /app

CMD /app/rel/web_server/bin/web_server start -p 8080 -p 8082

# docker build -t metrics:v2.0 .
# docker create -p 8082:8082 -p 8080:8080 --name webserverv_metrics  metrics:v2.0
# docker start webserverv_metrics
# docker exec -it webserverv_metrics bash
# docker run -it --rm -p 8080:8080 -p 8082:8082 --name webserver_metrics_v2  metrics:v2.0


# _build/prod/rel/web_server/bin/web_server start



# docker build -t web_ocp:v1 .

# crear tag para subir :  docker  tag metrics:v2.0   rocha7778/ocp_web_metrics:v.1
# subir imagen: docker push rocha7778/ocp_web_metrics:v.1
# docker create -p 8083:8082 --name webserverv2  web_ocp:v1
# subir imagen a ocp:  oc import-image rocha7778/ocp_web_metrics:v.1 --confirm

# oc port-forward redis-db8cb58f7-crrh5 6379:6379

#
# docker start webserver
# _build/prod/rel/web_server/bin/web_server start


# docker create -p 8083:8082 --name webserverv2  test_copy

