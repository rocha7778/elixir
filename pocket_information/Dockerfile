FROM artifactory.apps.bancolombia.com/evc/latest/elixir:1.13.3-alpine as build_image
ENV MIX_ENV=prod
WORKDIR /app
RUN  mix local.hex --force && mix local.rebar --force
COPY mix.exs mix.lock ./
RUN mix deps.get && mix deps.compile
COPY . .

RUN mix distillery.release


FROM artifactory.apps.bancolombia.com/evc/latest/elixir:1.13.3-alpine
ENV MIX_ENV=prod
WORKDIR /app
USER root
EXPOSE 8081
COPY --from=build_image /app/_build/prod/  /app


RUN chown -R appuser /app \
    && chmod -R 777 /app \
    && chmod -R 777 /app
   

USER appuser

CMD /app/rel/pocket_information/bin/pocket_information foreground

# docker build -t pocket_information:v1 .
# crear tag para subir :  docker tag web_ocp:v1  rocha7778/ocp_web:v1.0
# subir imagen: docker push rocha7778/ocp_web:v1.0
# docker create -p 8080:8080 --name pocket_information_v1  pocket_information:v1
# docker exec webserver bash -c "sleep 10"

# docker exec -it webserverv_metrics bash
# docker run -it --rm -p 8080:8080 --name pocket_information_v2  pocket_information:v1

# subir imagen a ocp:  oc import-image rocha7778/ocp_web:v1.0 --confirm
# oc port-forward redis-db8cb58f7-crrh5 6379:6379
#
# docker start webserver
# _build/prod/rel/web_server/bin/web_server start


# docker create -p 8083:8082 --name webserverv2  test_copy
