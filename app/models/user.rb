class User < ApplicationRecord
  #has_many
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         authentication_keys: [:login],
         omniauth_providers: [:google_oauth2]

  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  validate :validate_username
  attr_accessor :login
  has_and_belongs_to_many :oauth_providers

  def self.new_with_session(params, session)
    super.tap do |user|
      data = session['devise.oogle_oauth2_data']
      if data && session['devise.oogle_oauth2_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create( #name: data["name"],
        email: data['email'], username: data['email'],
        password: password, password_confirmation: password
      )

    end
    user
  end

  private

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end
end
