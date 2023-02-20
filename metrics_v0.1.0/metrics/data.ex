[
  %Telemetry.Metrics.Counter{
    description: nil,
    event_name: [:metrics, :emit],
    keep: nil,
    measurement: :value,
    name: [:metrics, :emit, :value],
    reporter_options: [],
    tag_values: #Function<0.31096282/1 in Telemetry.Metrics.default_metric_options/0>,
    tags: [],
    unit: :unit
  },
  %Telemetry.Metrics.Sum{
    description: nil,
    event_name: [:metrics, :request],
    keep: nil,
    measurement: :vale,
    name: [:metrics, :request, :vale],
    reporter_options: [],
    tag_values: #Function<0.31096282/1 in Telemetry.Metrics.default_metric_options/0>,
    tags: [],
    unit: :unit
  }
]

## grupos
%{
  [:metrics, :emit] => [
    %Telemetry.Metrics.Counter{
      description: nil,
      event_name: [:metrics, :emit],
      keep: nil,
      measurement: :value,
      name: [:metrics, :emit, :value],
      reporter_options: [],
      tag_values: #Function<0.31096282/1 in Telemetry.Metrics.default_metric_options/0>,
      tags: [],
      unit: :unit
    }
  ],
  [:metrics, :request] => [
    %Telemetry.Metrics.Sum{
      description: nil,
      event_name: [:metrics, :request],
      keep: nil,
      measurement: :vale,
      name: [:metrics, :request, :vale],
      reporter_options: [],
      tag_values: #Function<0.31096282/1 in Telemetry.Metrics.default_metric_options/0>,
      tags: [],
      unit: :unit
    }
  ]
}

gruops_v2 =
%{

  "a" => %{name: "rocha"},
  "b" => %{name: "paola"}
}


for {event, metrics} <- gruops_v2 do
  #IO.inspect(event)
  IO.inspect(metrics)
end


 for {event, metrics} <- groups do
    id = {"Customer", event, self()}
    IO.inspect(id)
  end


  metris =  [
    %Telemetry.Metrics.Sum{
      description: nil,
      event_name: [:metrics, :request],
      keep: nil,
      measurement: :vale,
      name: [:metrics, :request, :vale],
      reporter_options: [],
      tag_values: "#Function<0.31096282/1 in Telemetry.Metrics.default_metric_options/0>",
      tags: [],
      unit: :unit
    }
  ]

  measurements = %{value: 4}
  metadata = %{}

  metrics =  [
    %Telemetry.Metrics.Sum{
      description: nil,
      event_name: [:metrics, :request],
      keep: nil,
      measurement: :vale,
      name: [:metrics, :request, :vale],
      reporter_options: [],
      tag_values: "#Function<0.31096282/1 in Telemetry.Metrics.default_metric_options/0>",
      tags: [],
      unit: :unit
    }
  ]


   metrics
    |> Enum.map(fn metric -> handle_metric.(metric, measurements, metadata) end )
