#/spec/factories/sources.rb

FactoryGirl.define do

  factory :source do
    project
    title "Source Title"
    author "Source Author"
    url "http://google.com"
    comments "These are some comments on source."
  end
end
