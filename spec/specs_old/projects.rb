#/spec/factories/project.rb

FactoryGirl.define do
  factory :project do |p|
    p.user User.first
    sequence(:name) { |n| "Project ##{n}"}
  end
end
