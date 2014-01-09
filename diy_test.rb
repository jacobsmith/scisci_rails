  @user = User.new
  @user.username = "user#{Time.now}" 
  @user.password = 'foobarfoo'
  @user.save

  @project = Project.new
  @project.name = "Test Project"
  @project.user = @user
  @project.save

  @source = Source.new
  @source.title = "Test Title"
  @source.project = @project
  @source.save

  @note = Note.new
  @note.quote = "Test quote"
  @note.comments = "Test comments"
  @note.source = @source
  @note.save

  @tag = Tag.new
  @tag.name = "various comments"
  @tag.note = @note
  @tag.project = @project
  @tag.save
