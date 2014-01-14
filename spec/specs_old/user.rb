#/spec/factories/user.rb


FactoryGirl.define do

  sequence :username do |u|
    "User_#{u}"
  end

  factory :user do
    username
    password "password"
    password_confirmation "password"
  end
end
