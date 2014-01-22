class Ability
  include CanCan::Ability

  def initialize(user)
    # all users can manage their own items
    can :manage, Project, user: user.id
#    can :manage, Source, source.project.user: user.id

#    can :read, Project
    #    can :manage, Note { |note| note.source.project.user == user }
#    can :manage, Tag { |tag| tag.project.user == user }
#
#    # if a user is a collaborator on a project, can update, create, and read
#    # only creator can delete
#    can :update, Source,  
#    can :update, Note { |note| note.source.project.collaborators.include? user }
#    can :update, Tag { |tag| tag.project.collaborators.include? user }
#
#    can :create, Source { |source| source.project.collaborators.include? user }
#    can :create, Note { |note| note.source.project.collaborators.include? user }
#    can :create, Tag { |tag| tag.project.collaborators.include? user }
#
#    can :read, Source { |source| source.project.collaborators.include? user }
#    can :read, Note { |note| note.source.project.collaborators.include? user }
#    can :read, Tag { |tag| tag.project.collaborators.include? user }
  end
end
