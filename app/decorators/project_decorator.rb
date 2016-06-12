class ProjectDecorator < SimpleDelegator
  def thesis
    super || "It appears you haven't written a thesis yet..."
  end
end
