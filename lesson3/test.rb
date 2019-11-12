require_relative 'classes'

stat1 = Station.new('stat1')
stat2 = Station.new('stat2')
stat3 = Station.new('stat3')
абдырвалг = Station.new('абдырвалг')

route1 = Route.new(stat1, stat3)
route1.add_station(stat2)
route1.add_station(абдырвалг)

train1 = Train.new(123, :freight, 5)
train1.acquire_route(route1)
puts train1.next_station
puts '#'
puts stat1.trains
puts '#'
train1.move_forward
puts stat1.trains
puts '#'
puts stat2.trains

