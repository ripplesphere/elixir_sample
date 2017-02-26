# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirSample.Repo.insert!(%ElixirSample.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alerts = File.read!("/home/george/mbta/waze_alerts.json") |> Poison.decode!() # this should probably be exsoda but the module failed in multiple locations when tests were run
a_data = alerts["data"]

# Definitely could use some error handling in throughout here.
Enum.map(a_data, fn my_list -> 
      {time_end, _} = List.pop_at(my_list, 8)
      {_, timee, _} = DateTime.from_iso8601(time_end <> "-05:00")
      time_end_f = Ecto.DateTime.cast!(timee)
      {location_st, _} = List.pop_at(my_list, 9)
      {location_city, _} = List.pop_at(my_list, 10)
      {locx, _} = List.pop_at(my_list, 13)
      {locy, _} = List.pop_at(my_list, 14)
      {hazard, _} = List.pop_at(my_list, 15)
      {hazard_type, _} = List.pop_at(my_list, 18)
      {time_start, _} = List.pop_at(my_list, 22)
      {_, times, _} = DateTime.from_iso8601(time_start <> "-05:00")
      time_start_f = Ecto.DateTime.cast!(times)
      ElixirSample.Repo.insert!(%ElixirSample.Alert{time_end: time_end_f, location_st: location_st, location_city: location_city, locx: locx, locy: locy, hazard: hazard, hazard_type: hazard_type, time_start: time_start_f})
      end
   )
