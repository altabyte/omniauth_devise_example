class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = '4JxXB29SN7cAVsa@email'
  TEMP_EMAIL_REGEX  = /\A#{TEMP_EMAIL_PREFIX}/i

  has_many :identities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:linkedin, :facebook]

  validates :encrypted_password, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [:create, :update] }


  # Find the User whose details match the auth data hash returned by the OAuth provider
  # @return [User] an existing or newly created user.
  #
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource || identity.user

    # Create the user if not found
    if user.nil?
      email = auth.info.email
      user = User.where(email: email).first
      if user.nil?
        email = "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com" if email.blank?
        user = User.new(
            #name: auth.extra.raw_info.name,
            #username: auth.info.nickname,
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation! # Skip Devise.confirmable
        user.save!
      end
    end

    # Associate the identity with the user if necessary.
    # This should only be necessary when linking an 'additional' OAuth account to the user.
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def temporary_email?
    !(self.email =~ TEMP_EMAIL_REGEX).nil?
  end
end
