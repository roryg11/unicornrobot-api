class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_confirmation_token!
  after_create :update_access_token!

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

  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def email_activate
    self.unconfirmed_email = false
    self.confirmation_token = nil
    save!(:validate => false)
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
      token = "#{self.id}:#{Devise.friendly_token}"
      break token unless User.where(access_token: token).first
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def generate_confirmation_token!
    if self.confirmation_token.blank?
      generate_token("confirmation_token")
    end
  end
end
