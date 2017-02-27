defmodule ElixirSample.AlertTest do
  use ElixirSample.ModelCase

  alias ElixirSample.Alert

  @valid_attrs %{hazard: "some content", hazard_type: "some content", location_city: "some content", location_st: "some content", locx: "some content", locy: "some content", time_end: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, time_start: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Alert.changeset(%Alert{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Alert.changeset(%Alert{}, @invalid_attrs)
    refute changeset.valid?
  end
end
