defmodule ElixirSample.JamController do
   use ElixirSample.Web, :controller

   alias ElixirSample.Alert

   def index(conn, _params) do
      query = from(a in Alert,
               select: {count(a.id)},
               where: a.hazard_type == "JAM")
      tot_num = Number.Delimit.number_to_delimited(elem(hd(Repo.all(query)), 0), precision: 0)
      render(conn, "index.html", tot_num: tot_num)
   end
end
