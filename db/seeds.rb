# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all

6.times do
  bio = Faker::Lorem.sentence(word_count: 10)
  nickname = Faker::Sports::Basketball.player
  email = Faker::Internet.free_email
  avatar_color = %w[blue green red][rand(0..2)]
  address = ['1 rue Sainte Catherine Bordeaux',
             '3 cours Alsace-Lorraine Bordeaux',
             '18 cours de la Marne Bordeaux',
             'Place des Quinconces Bordeaux',
             '175 cours du Medoc Bordeaux',
             '180 cours Balguerie Stuttengerg Bordeaux'][rand(0..5)]
  User.create(nickname: nickname,
              email: email,
              password: 'secret',
              avatar_color: avatar_color,
              score: 0,
              city: address,
              bio: bio)
end
