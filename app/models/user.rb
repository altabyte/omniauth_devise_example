class User < ActiveRecord::Base

  has_many :identities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

end
