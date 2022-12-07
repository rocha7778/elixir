defmodule Test do

  def validate_status_code!(status_caode) do
    case status_caode do
      400 -> raise( "Bad rquest")
      500 -> raise ("Internal Error")
      _ -> status_caode
    end
  end

end
