defmodule TestAbstraction do
  def test do
    days = MapSet.new() |>
    MapSet.put(:monday)|>
    MapSet.put(:tuesday)|>
    MapSet.put(:wednesday)|>
    MapSet.put(:thursday)|>
    MapSet.put(:fryday)|>
    MapSet.put(:saturday)|>
    MapSet.put(:sunday)

    days


  end

end
