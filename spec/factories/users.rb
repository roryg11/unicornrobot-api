require 'devise'
token =  Devise.friendly_token
FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    username {Faker::Team.creature}
    password {'password'}
    confirmed_at Date.today
    access_token "8#{token}"
  end
end
