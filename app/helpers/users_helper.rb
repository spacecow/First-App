module UsersHelper
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag @user.email, :class => "gravatar",
    :alt => user.name,
    :gravatar => options
  end
end
