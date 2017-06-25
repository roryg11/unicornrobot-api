class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :update_access_token!

  has_many :interests, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true

  def setAdminRole
    self.role = "ADMIN"
    save
  end

  def setAmbassadorRole
    self.role = "AMBASSADOR"
    save
  end

  def setIndividual
    self.role = "INDIVIDUAL"
    save
  end

  def getRoles
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
