# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 User.create name: "Paul Lee", email: "pauly0418@gmail.com", password: "hello", password_confirmation: "hello", admin: true

 User.create name: "John Lee", email: "johnlee@gmail.com", password: "hello", password_confirmation: "hello", admin: false
