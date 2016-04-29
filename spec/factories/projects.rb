#/spec/factories/project.rb

FactoryGirl.define do
  factory :project do
    user
    sequence(:name) { |n| "Project ##{n}"}
  end
end
