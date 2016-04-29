#/spec/factories/tags.rb

FactoryGirl.define do
  factory :tag do
    note
    sequence(:name) { |n| "Tag ##{n}"}
  end
end
