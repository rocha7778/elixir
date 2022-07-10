defmodule Todo do
  import Saxy.XML
  import UUID

  @il_namespace "http://grupobancolombia.com/intf/IL/esbXML/V3.0"
  @eqmg_namespace "http://grupobancolombia.com/intf/componente/tecnico/homologacion/RecuperarParametrizacionEquivalencias/V2.0"

  @system_id "elixir"
  @user_name "user"
  @service_name "Service"
  @service_namespace "http://grupobancolombia.com/intf/Domain/Area/Service/V1.0"
  @service_operation "operation"

  def hello do
    element = element("person", [gender: "female"], "Alice")
    IO.inspect(element)
    result = Saxy.encode!(element, version: "1.0")
    IO.inspect(result)
    message_id = UUID.uuid1()

    interaction_data =
      element("interactionData", [], element("timestamp", [], current_timestamp()))

    system_id = element("systemId", [], @system_id)
    message_id = element("messageId", [], message_id)

    result2 =
      element("Header", [], [
        system_id,
        message_id,
        interaction_data
      ])

      result2 = Saxy.encode!(result2, version: "1.0")
    IO.inspect(result2)






    :world


  end

  def current_timestamp() do
    {:ok, date_time} =
      :calendar.universal_time()
      |> :calendar.universal_time_to_local_time()
      |> NaiveDateTime.from_erl()

    NaiveDateTime.to_iso8601(date_time)
  end
end
