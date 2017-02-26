defmodule ElixirSample.RoadClosedController do
   use ElixirSample.Web, :controller

   alias ElixirSample.Alert

   def index(conn, _params) do
      query = from(a in Alert,
               select: {count(a.id)},
               where: a.hazard_type == "ROAD_CLOSED")
      tot_num = elem(hd(Repo.all(query)), 0)
      render(conn, "index.html", tot_num: tot_num)
   end
end
