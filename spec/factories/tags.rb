#/spec/factories/tags.rb

FactoryGirl.define do
  factory :tag do |t|
    t.note build(:note)
    sequence(:name) { |n| "Tag ##{n}"}
  end
end
