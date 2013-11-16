require 'date'
require 'carrierwave/orm/activerecord'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_weeks
    make_weekends
    make_relationships
    make_votes
    make_images
  end
end

def make_users
  User.create!(name: "Alex",
   email: "example@railstutorial.org",
   password: "foobar",
   password_confirmation: "foobar",
   admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name: name,
     email: email,
     password: password,
     password_confirmation: password)
  end
end

def make_weeks
  dates = [[2013,10,19], [2013,10,12], [2013,10,5], [2013,11,02]]
  dates.map do |date|
    Week.create!(date: (Date.new *date))
  end
end

def make_weekends
  users = User.all
  weeks = Week.all
  users.each do |user|
    weeks.each { |week| user.weekends.create!(week_id: week.id) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers     = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_votes
  users = User.all
  voter = users.first
  authors = users[2..30]
  authors.each do |author|
    author.weekends.each do |weekend|
      weekend.votes.create!(user_id: voter.id)
    end
  end
end

def make_images
  weekends = Weekend.all
  weekends.each do |weekend|
    image = weekend.images.create!
    image.image = File.open("app/assets/images/sample_image.jpg")
    image.save!
  end
end