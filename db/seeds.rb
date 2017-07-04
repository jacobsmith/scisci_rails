# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed
  begin
    User.create(username: 'admin@example.com', password: 'asdfasdf')

    teacher = User.create(username: 'teacher', password: 'password')
    english = Section.create(name: "English - 1st Period")
    philosophy = Section.create(name: "Philosophy - 2nd Period")

    english.teachers << teacher
    philosophy.teachers << teacher

    10.times do |i|
      user = User.create(username: "test_user_#{i}_#{Time.current.to_i}", password: "password", nickname: "#{rand < 0.5 ? "John" : "Jane"} Doe #{i}")

      if (i % 2 == 0)
        english.students << user
      else
        philosophy.students << user
      end

      3.times do |p|
        project = Project.create(name: "test project #{p}", user: user)
        project.feedback << Comment.create(commentable: project, comment: "This project (#{project.id}) looks great!", author: teacher)

        3.times do |s|
          source = Source.create(project: project, title: "Test Source #{s}", source_type: ["web", "book", "magazine"].sample)
          source.feedback << Comment.create(commentable: source, comment: "This source (#{source.id}) looks great!", author: teacher)

          3.times do |n|
            note = Note.create(project: project, source: source, quote: "Test quote #{[i,p,s,n].join("-")}", comments: "Test Comment #{[i,p,s,n].join("-")}")
            note.feedback << Comment.create(commentable: note, comment: "This note (#{note.id}) looks great!", author: teacher)
          end
        end
      end
    end

  rescue ActiveRecord::RecordInvalid => e
    puts "ERROR!"
    puts e.errors
  end
end

seed
