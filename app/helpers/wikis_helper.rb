module WikisHelper
  def canSee(user, wiki)
    !wiki.private || wiki.user_id == user.id || user.admin? || user.premium?
  end
end
