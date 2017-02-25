defmodule ElixirSample.Alert do
  use ElixirSample.Web, :model

  schema "alerts" do
    field :time_end, Ecto.Time
    field :location_st, :string
    field :location_city, :string
    field :locx, :string
    field :locy, :string
    field :hazard, :string
    field :hazard_type, :string
    field :time_start, Ecto.Time

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time_end, :location_st, :location_city, :locx, :locy, :hazard, :hazard_type, :time_start])
    |> validate_required([:time_end, :location_st, :location_city, :locx, :locy, :hazard, :hazard_type, :time_start])
  end
end
