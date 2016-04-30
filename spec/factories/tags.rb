#/spec/factories/tags.rb

FactoryGirl.define do
  factory :tag do
    project
    note
    sequence(:name) { |n| "Tag ##{n}"}
  end
end
