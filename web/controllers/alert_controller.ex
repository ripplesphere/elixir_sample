defmodule ElixirSample.AlertController do
  use ElixirSample.Web, :controller

  alias ElixirSample.Alert

  def index(conn, _params) do
    alerts = Repo.all(Alert)
    render(conn, "index.html", alerts: alerts)
  end

  def new(conn, _params) do
    changeset = Alert.changeset(%Alert{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"alert" => alert_params}) do
    changeset = Alert.changeset(%Alert{}, alert_params)

    case Repo.insert(changeset) do
      {:ok, _alert} ->
        conn
        |> put_flash(:info, "Alert created successfully.")
        |> redirect(to: alert_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    alert = Repo.get!(Alert, id)
    render(conn, "show.html", alert: alert)
  end

  def edit(conn, %{"id" => id}) do
    alert = Repo.get!(Alert, id)
    changeset = Alert.changeset(alert)
    render(conn, "edit.html", alert: alert, changeset: changeset)
  end

  def update(conn, %{"id" => id, "alert" => alert_params}) do
    alert = Repo.get!(Alert, id)
    changeset = Alert.changeset(alert, alert_params)

    case Repo.update(changeset) do
      {:ok, alert} ->
        conn
        |> put_flash(:info, "Alert updated successfully.")
        |> redirect(to: alert_path(conn, :show, alert))
      {:error, changeset} ->
        render(conn, "edit.html", alert: alert, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    alert = Repo.get!(Alert, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(alert)

    conn
    |> put_flash(:info, "Alert deleted successfully.")
    |> redirect(to: alert_path(conn, :index))
  end
end
