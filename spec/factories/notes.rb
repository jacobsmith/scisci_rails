#/spec/factories/notes.rb

FactoryGirl.define do
  factory :note do
    quote "This is a quote on the note"
    comments "These are some comments on the note"
    source
  end
end
