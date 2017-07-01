# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'admin@example.com', password: 'asdfasdf')

teacher = User.create(username: 'teacher', password: 'password')
english = Section.create(name: "English - 1st Period")

english.teachers << teacher

10.times do |i|
  user = User.create(username: "test_user_#{i}_#{Time.current.to_i}", password: "password", nickname: "John Doe #{i}")
  english.students << user
  3.times do |p|
    project = Project.create(name: "test project #{p}")
    3.times do |s|
      source = Source.create(project: project, title: "Test Source #{s}", source_type: ["web", "book", "periodical"].sample)
      3.times do |n|
        note = Note.create(project: project, source: source, quote: "Test quote #{[i,p,s,n].join("-")}", comments: "Test Comment #{[i,p,s,n].join("-")}")
      end
    end
  end
end
