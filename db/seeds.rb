# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Example User",email: "example@lalith.info",password: "foobar",password_confirmation: "foobar")
User.create!(name: "Example User",email: "me@lalith.info",password: "foobar",password_confirmation: "foobar",admin: true)
60.times do |n|
    name = Faker::Name.name
    email = "test-#{n+1}@lalith.info"
    password = "password"
    User.create!(name: name,email: email,password: password,password_confirmation: password)
    
end