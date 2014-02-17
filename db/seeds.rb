# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = []
projects = []
sources = []
notes = []

teacher = Teacher.create(username: 'teacher', password: 'password', password_confirmation: 'password')
section = Section.create(teacher_id: teacher.id, name: "Section 1")

10.times do |i|
  username = "user#{i}"
  student = Student.create(username: username, password: 'password', password_confirmation: 'password')
  Student_Section_Relation.create(student_id: student.id, section_id: section.id)
  users << student
end

10.times do |i|
  section.deploy_project "Hopefully this works! #{i}"
end

# users.each do |user|
#   10.times do |i|
#     projects << Project.create(user: user, name: "Test Project ##{i}", section_id: section.id, teacher_id: teacher.id, section_project_id: i)
#   end
# end

projects.each do |project|
  10.times do |i|
    sources << Source.create(project: project, title: "Test title #{i}", author: "Anthony", url: "http://www.google.com/abcdefghijklmnopqrstyuvwxyz")
  end
end

sources.each do |source|
  10.times do |i|
    notes << Note.create(source: source, quote: "This is a test quote ##{i}", comments: "These are some test comments")
  end
end
