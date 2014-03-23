# spec/factories/chain.rb

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User_#{n}"}
    password 'password'
    password_confirmation 'password'
  end
  
  factory :project do
    user 
    name "Test project"
  end

  factory :source do
    project
    title "Source Title"
    authors ""
    url "google.com"
    comments "these are some comments"
  end

  factory :note do
    source
    comments "These are some comments"
    quote "This is a quote"
  end

  factory :tag do
    project
    note
    sequence(:name) { |n| "tag_#{n}"}
  end

end
