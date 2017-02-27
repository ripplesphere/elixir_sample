defmodule ElixirSample.RoadClosedController do
   use ElixirSample.Web, :controller

   alias ElixirSample.Alert

   def index(conn, _params) do
      query = from(a in Alert,
               select: {count(a.id)},
               where: a.hazard_type == "ROAD_CLOSED")
      tot_num = Number.Delimit.number_to_delimited(elem(hd(Repo.all(query)), 0), precision: 0)

      query = from(a in Alert,
                distinct: true,
                select: a.hazard,
                where: a.hazard_type == "ROAD_CLOSED")
      [ _ | hazard_classes ] = Repo.all(query)

      hazard_count = Enum.map(hazard_classes, fn hazard ->
         query = from(a in Alert, 
                     select: {count(a.id)}, 
                     where: a.hazard_type == "ROAD_CLOSED" and a.hazard == ^hazard)
         num_reported = Number.Delimit.number_to_delimited(elem(hd(Repo.all(query)), 0), precision: 0)
         end
      )

      hazard_row = Enum.zip(hazard_classes, hazard_count)

      render(conn, "index.html", tot_num: tot_num, hazard_row: hazard_row)
   end
end
