class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :update_access_token!

  # validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, unless: "password.nil?"
  validates :password, presence: true, if: "id.nil?"
  # validates :password, confirmation: true, if: "id.nil?"
  # we want the above for changing your password when you update, but not sure


  def setAdminRole
    self.role = roles.ADMIN
    save
  end

  def setAmbassadorRole
    self.role = roles.AMBASSADOR
    save
  end

  def setIndividual
    self.role = roles.INDIVIDUAL
    save
  end

  def roles
    {
      ADMIN: "Admin",
      AMBASSADOR: "Ambassador",
      INDIVIDUAL: "Individual"
    }
  end

  def assignUserGroup
    self.user_group_id = 1
    save
  end

  private

  #  Need to change to something more secure if you want to keep this token secure
  #  replace this with JSON Webtokens getting from the authorization header instead
  #  and using that in the session serializer
  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

  def generate_access_token
    loop do
      token = "#{self.id}:Devise.friendly_token"
      break token unless User.where(access_token: token).first
    end
  end

end
