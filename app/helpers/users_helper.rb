# users helper
module UsersHelper
  def get_username(id)
    return User.find(id).username if User.exists?(id)
    render html: 'Player No Longer Active'
  end
end
