module ApplicationHelper
  #helper function for attaching image
  def avatar_url(user)
     if user.avatar.attached?
      url_for(user.avatar)
     elsif user.image?
        user.image
     else
      ActionController::Base.helpers.asset_path('icon_default_avatar.png')
     end
  end
end
