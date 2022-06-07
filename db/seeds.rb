# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all



User.create(nickname: 'Admin',
            email: 'admin@huge.com',
            password: 'secret',
            avatar_color: 'green',
            score: 900,
            city: '176 cours Balguerie Stuttenberg 33000 Bordeaux',
            bio: Faker::Lorem.sentence(word_count: 10),
            logged_in: [true, false].sample)


6.times do
  bio = Faker::Lorem.sentence(word_count: 10),
  nickname = Faker::Sports::Basketball.player,
  email = Faker::Internet.free_email,
  avatar_color = '#3D3D3D',
  address = ['1 rue Sainte Catherine, Bordeaux',
             '3 cours Alsace-Lorraine, Bordeaux',
             '18 cours de la Marne, Bordeaux',
             'Place Quinconces, Bordeaux',
             '175 cours du Médoc, Bordeaux',
             '180 cours Balguerie Stuttenberg, Bordeaux'][rand(0..5)]
  User.create(nickname: nickname,
              email: email,
              password: 'secret',
              avatar_color: avatar_color,
              score: rand(0..1000),
              city: address,
              bio: bio,
              logged_in: [true, false].sample)
end

User.create(nickname: 'Desty',
            email: 'desty@huge.com',
            password: 'secret',
            avatar_color: 'green',
            score: 750,
            city: '152 cours Balguerie Stuttenberg 33000 Bordeaux',
            bio: Faker::Lorem.sentence(word_count: 10),
            logged_in: true)

Hug.create(
  sender_id: 1,
  receiver_id: 8,
  progress: 0
)

users = User.all
users.each do |user|
  if user.score < 100
    user.avatar = "avatars/Cactus1.png"
  else
    level = (user.score.round(-2) / 100)
    user.avatar = "avatars/Cactus#{level}.png"
    user.save
  end
end
