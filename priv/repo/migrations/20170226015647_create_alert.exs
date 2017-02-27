defmodule ElixirSample.Repo.Migrations.CreateAlert do
  use Ecto.Migration

  def change do
    create table(:alerts) do
      add :time_end, :datetime
      add :location_st, :string
      add :location_city, :string
      add :locx, :string
      add :locy, :string
      add :hazard, :string
      add :hazard_type, :string
      add :time_start, :datetime

      timestamps()
    end

  end
end
