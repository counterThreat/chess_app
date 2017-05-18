# users helper
module UsersHelper
  def get_username(id)
    return User.find(id).username if User.exists?(id)
    render html: 'Player No Longer Active'
  end

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
    image_tag(gravatar_url, alt: user.username)
  end
end
