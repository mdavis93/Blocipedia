class WikiPolicy < ApplicationPolicy

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def destroy?
    user && (@user.admin? || @wiki.user_id == @user.id)
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.owner == user || wiki.collaborators.exists?(user_id: user.id)
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
