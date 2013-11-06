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

  factory :weekend do
  	week Date.new(2013,10,19)
  	user
  end

  factory :vote do
    user
    weekend
  end
end