# spec/factories/chain.rb

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User_#{n}"}
    password 'password'
    password_confirmation 'password'
  end

  factory :owned_project do
    after :create do |user|
      create(:project, user: user)
    end
  end

    factory :owned_source do
      after :create do |source|
        create(:source, project: owned_project)
      end
    end

      factory :owned_note do
        after :create do |note|
          create(:note, source: owned_source)
        end
      end

        factory :owned_tag do
          after :create do |tag|
            create(:tag, note: owned_note, project: owned_project)
          end
        end

  factory :project do
    name "Test project"
  end

  factory :source do
    title "Source Title"
    author "Source Author"
    url "google.com"
    comments "these are some comments"
  end

  factory :note do
    comments "These are some comments"
    quote "This is a quote"
  end

  factory :tag do
    sequence(:name) { |n| "tag_#{n}"}
  end

end
