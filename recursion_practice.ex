defmodule Loop do
  def convert_list(list) do
    list_to_tuple_list(list, [])
  end

  def list_to_tuple_list([], tuple_list) do
    tuple_list
  end

  def list_to_tuple_list(list, tuple_list) do
    tuple = List.first(list)
    element = elem(tuple,0)
    first_element_of_tuple = convert_atom(element)
    second_element_of_tuple = elem(tuple,1)
    list = List.delete_at(list, 0)
    tuple_list = [{first_element_of_tuple, second_element_of_tuple} | tuple_list]
    IO.inspect(tuple_list, label: :tuple_list)
    list_to_tuple_list(list, tuple_list)
  end

  defp convert_atom (element) do
    if is_atom(element) do
      Atom.to_string(element)
    else
      element
    end
  end

  def get_message_id(headers, header_name) do
    case Enum.find(headers, fn header_tuple -> elem(header_tuple, 0) == header_name end) do
      nil -> {:error, :not_found}
      {_, ""} -> {:error, :not_found}
      {_, message_id_value} -> {:ok, message_id_value}
    end
  end

end





list = [
  accept: "application/vnd.bancolombia.v3+json",
  "accept-encoding": "gzip, deflate, br",
  authorization: "Basic YWRtaW46YWRtaW4=",
  connection: "keep-alive",
  "content-length": "270",
  "content-type": "application/vnd.bancolombia.v3+json",
  host: "localhost:8080",
  "message-id": "b9757392-2322-11ed-861d-0242ac1200023",
  "postman-token": "2a39ab72-9d55-49b3-add4-2eb6e24b39361",
  "user-agent": "PostmanRuntime/7.29.2",
  "x-ibm-client-id": "123456",
  "x-ibm-client-secret": "123456"
]

list_wanted =  [
  {"accept", "application/vnd.bancolombia.v3+json"},
  {"accept-encoding", "gzip, deflate, br"},
  {"authorization", "Basic YWRtaW46YWRtaW4="},
  {"connection", "keep-alive"},
  {"content-length", "319"},
  {"content-type", "application/vnd.bancolombia.v3+json"},
  {"host", "localhost:8080"},
  {"postman-token", "b3681e7a-542f-47e2-a3cb-f4caaf3c4109"},
  {"user-agent", "PostmanRuntime/7.29.2"},
  {"x-ibm-client-id", "123456"},
  {"x-ibm-client-secret", "123456"},
  {"message-id", ""}

]

list = [
  {"accept", "application/vnd.bancolombia.v3+json"},
  {"accept-encoding", "gzip, deflate, br"},
  {"authorization", "Basic YWRtaW46YWRtaW4="},
  {"connection", "keep-alive"},
  {"content-length", "319"},
  {"content-type", "application/vnd.bancolombia.v3+json"},
  {"host", "localhost:8080"},
  {"message-id", ""},
  {"postman-token", "0ee5c5a8-ca29-4767-9509-f2da75a71672"},
  {"user-agent", "PostmanRuntime/7.29.2"}
]

headers, fn header_tuple -> elem(header_tuple, 0) == header_name end

Enum.reject(headers, fn header_tuple -> elem(header_tuple, 0) == "message-id" end)

[{"message-id", UUID.uuid1()} | list]



Loop.get_message_id(list_wanted, "message-id")



Loop.convert_list(list)

hola = List.delete_at(list, 0)
