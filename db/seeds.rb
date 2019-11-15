# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 Organisation.find_or_create_by(name: "Domino's Pizza", hourly_rate: 10.0)
 Organisation.find_or_create_by(name: "Truffles", hourly_rate: 15.0)
 Organisation.find_or_create_by(name: "Starbucks", hourly_rate: 20.0)
