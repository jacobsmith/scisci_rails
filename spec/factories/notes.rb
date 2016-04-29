#/spec/factories/notes.rb

FactoryGirl.define do
  factory :note do
    source Source.first
    quote "This is a quote on the note"
    comments "These are some comments on the note"
    sequence(:tags) { |t| "Tag_#{t}"}
  end
end
