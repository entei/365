module UsersHelper
 # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=150"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end
  # Get events count
  def events_count(user)
    user.events.count
  end
  # Get stickers count
  def stickers_count(user)
    user.sticker.count
  end

  # Device resource
  def resource_name
    :user
  end

  def resource
    @resource ||= current_user
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
