require 'date'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_weekends
    make_relationships
  end
end

def make_users
    User.create!(name: "Example User",
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

def make_weekends
    users = User.all
    weeks = [[2013,10,19], [2013,10,12], [2013,10,5]]
    weeks.map do |date|
      users.each { |user| user.weekends.create!(week: (Date.new *date)) }
    end
  end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end