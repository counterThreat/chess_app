# users helper
module UsersHelper
  def get_username(id)
    User.find(id).username
  end
end
