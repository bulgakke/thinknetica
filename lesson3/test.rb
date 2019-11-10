require_relative 'classes'

stat1 = Station.new('stat1')
stat2 = Station.new('stat2')
stat3 = Station.new('stat3')
абдырвалг = Station.new('абдырвалг')

route1 = Route.new(stat1, stat2)

route1.add_station('абдырвалг')
route1.add_station('stat3')

thomas = Train.new(228, :freight, 5)
thomas.acquire_route(route1)
thomas.move_back
thomas.status

