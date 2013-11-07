FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
	    admin true
    end
  end

  factory :week do
    date Date.new(2013,11,02)
  end

  factory :weekend do
  	week
  	user
  end

  factory :vote do
    user
    weekend
  end
end