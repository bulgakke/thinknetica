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
puts stat2.trains_by_type(:passenger)
t1 = Train.new(1, :freight, 5)
t2 = Train.new(2, :passenger, 5)
t3 = Train.new(3, :freight, 5)
t4 = Train.new(4, :freight, 5)
t5 = Train.new(5, :passenger, 5)
t6 = Train.new(6, :passenger, 5)
t7 = Train.new(7, :freight, 5)
t8 = Train.new(8, :passenger, 5)
[t1, t2, t3, t4, t5, t6, t7, t8].each do |t|
  t.acquire_route(route1)
  t.move_forward
end
puts 'Passenger trains:'
puts stat2.trains_by_type(:passenger)
puts 'Freight trains:'
puts stat2.trains_by_type(:freight)