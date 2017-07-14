FactoryGirl.define do
  sequence :username do |u|
    "User_#{u}"
  end

  factory :user do
    username
    password "password"
    password_confirmation "password"
  end

  factory :admin do
    username "admin"
    password "password"
  end
end
