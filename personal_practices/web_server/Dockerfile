

FROM elixir as build_image
WORKDIR /app
RUN  mix local.hex --force && mix local.rebar --force
COPY mix.exs mix.lock ./
RUN mix deps.get && mix deps.compile
COPY . .
RUN mix distillery.release


ENV MIX_ENV=prod
USER root
EXPOSE 8081

CMD /app/rel/web_server/bin/web_server foreground




# docker build -t credit_card_test:v30 .
# crear tag para subir :  docker tag web_ocp:v1  rocha7778/ocp_web:v1.0
# subir imagen: docker push rocha7778/ocp_web:v1.0
# docker create -p 8085:8085 --name credit_card_test_v30  credit_card_test:v30
# docker exec webserver bash -c "sleep 10"

# docker exec -it webserverv_metrics bash
# docker run -it --rm -p 8080:8080 --name credit_card_test_v30  credit_card_test:v30

# subir imagen a ocp:  oc import-image rocha7778/ocp_web:v1.0 --confirm
# oc port-forward redis-db8cb58f7-crrh5 6379:6379
#
# docker start webserver
# _build/prod/rel/web_server/bin/web_server start


# docker create -p 8083:8082 --name webserverv2  test_copy
