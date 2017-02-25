defmodule ElixirSample.AlertControllerTest do
  use ElixirSample.ConnCase

  alias ElixirSample.Alert
  @valid_attrs %{hazard: "some content", hazard_type: "some content", location_city: "some content", location_st: "some content", locx: "some content", locy: "some content", time_end: %{hour: 14, min: 0, sec: 0}, time_start: %{hour: 14, min: 0, sec: 0}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, alert_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing alerts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, alert_path(conn, :new)
    assert html_response(conn, 200) =~ "New alert"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, alert_path(conn, :create), alert: @valid_attrs
    assert redirected_to(conn) == alert_path(conn, :index)
    assert Repo.get_by(Alert, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, alert_path(conn, :create), alert: @invalid_attrs
    assert html_response(conn, 200) =~ "New alert"
  end

  test "shows chosen resource", %{conn: conn} do
    alert = Repo.insert! %Alert{}
    conn = get conn, alert_path(conn, :show, alert)
    assert html_response(conn, 200) =~ "Show alert"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, alert_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    alert = Repo.insert! %Alert{}
    conn = get conn, alert_path(conn, :edit, alert)
    assert html_response(conn, 200) =~ "Edit alert"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    alert = Repo.insert! %Alert{}
    conn = put conn, alert_path(conn, :update, alert), alert: @valid_attrs
    assert redirected_to(conn) == alert_path(conn, :show, alert)
    assert Repo.get_by(Alert, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    alert = Repo.insert! %Alert{}
    conn = put conn, alert_path(conn, :update, alert), alert: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit alert"
  end

  test "deletes chosen resource", %{conn: conn} do
    alert = Repo.insert! %Alert{}
    conn = delete conn, alert_path(conn, :delete, alert)
    assert redirected_to(conn) == alert_path(conn, :index)
    refute Repo.get(Alert, alert.id)
  end
end
