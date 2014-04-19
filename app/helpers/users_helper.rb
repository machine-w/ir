module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user,size)
    # gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # image_tag(gravatar_url, alt: user.username, class: "img-circle")
    image_tag(user.avatar_url(size),class: "img-circle") if user && user.avatar
  end
end
