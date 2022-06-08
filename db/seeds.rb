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
            score: 247,
            city: '176 cours Balguerie Stuttenberg, 33000 Bordeaux',
            biography: Faker::ChuckNorris.fact,
            logged_in: true)

User.create(nickname: 'HuggyCactus',
            email: 'huggycactus@huge.com',
            password: 'secret',
            avatar_color: 'green',
            score: rand(101..590),
            city: '8 rue Joséphine, 33300 Bordeaux',
            logged_in: true,
            biography: Faker::ChuckNorris.fact)




15.times do

  nickname = Faker::Sports::Basketball.player
  email = "user#{rand(0..20)}@huge.com"
  avatar_color = '#3D3D3D'
  city = [   "175 rue Sainte Catherine, Bordeaux",
             "80 cours de Verdun, Bordeaux",
             "25 rue Mandron, Bordeaux",
             "24 rue de la Course, Bordeaux",
             "132 cours Alsace-Lorraine, Bordeaux",
             "cours de la Marne, Bordeaux",
             "275 avenue Thiers, Bordeaux",
             "48 cours du Médoc, Bordeaux",
             "18 rue Ferrère, Bordeaux",
             "162 cours Balguerie Stuttenberg, Bordeaux"].sample
  User.create(nickname: nickname,
              email: email,
              password: 'secret',
              avatar_color: avatar_color,
              score: rand(101..590),
              city: city,
              logged_in: [true, false].sample,
              biography: Faker::ChuckNorris.fact)
end

Hug.create(
  sender_id: 1,
  receiver_id: 2,
  progress: 0
)

users = User.all
users.each do |user|
  if user.score < 100
    user.avatar = "avatars/Cactus1.png"
  else
    level = (user.score.round(-2) / 100)
    user.avatar = "avatars/Cactus#{level + 1}.png"
    user.save
  end
end
