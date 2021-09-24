# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(
  email:      'foo@bar.com',
  first_name: 'John',
  last_name:  'Smith',
  mobile:     44123456789
)

host = Host.create!(
  email:      'foo@bar.com',
  first_name: 'John',
  last_name:  'Smith',
  mobile:     44123456789
)

Booking.create!([
  {
    start_time: 1.day.from_now.change(hour: 12),
    end_time:   1.day.from_now.change(hour: 13),
    user:       user,
    state:      'provisional'
  },
  {
    start_time: 1.day.from_now.change(hour: 14),
    end_time:   1.day.from_now.change(hour: 15),
    user:       user,
    host:       host,
    state:      'provisional'
  },
  {
    start_time: 2.days.from_now.change(hour: 12),
    end_time:   2.days.from_now.change(hour: 12),
    user:       user,
    host:       host
    state:      'cancelled'
  }
])
