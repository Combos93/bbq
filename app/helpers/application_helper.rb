module ApplicationHelper
  def user_avatar(user)
    # TODO load real avatar/picture
    asset_path('user.png')
  end
end
