class WikiPolicy < ApplicationPolicy

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def destroy?
    user && (@user.admin? || @wiki.user_id == @user.id)
  end

  def edit?
    user && (@user.admin? || @wiki.collaborators.exists?(user_id: user.id))
  end

  def show?
    !@wiki.private || (@user && @wiki.private && (@wiki.user_id == @user.id || @user.admin? || @wiki.collaborators.exists?(user_id: @user.id)) )
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user && user.role == 'admin'
        wikis = scope.all
      elsif user && user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.user_id == user.id || wiki.collaborators.exists?(user_id: user.id)
            wikis << wiki
            puts "Collaborator or Admin"
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.collaborators.exists?(user_id: user.id)
            if wiki.collaborators.exists?(user_id: user.id)
              puts "\n\nNon Premium Collaborator Found\n\n"
            end
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
