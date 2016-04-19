class User < ActiveRecord::Base
  rolify

  attr_accessor :login

  has_many :messages, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  belongs_to :role

  after_validation :geocode
  after_create :assign_user_role

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = parmas
        user.valid?
      end
    else
      super
    end
  end

  geocoded_by :full_address, if: :full_address_changed?

  def full_address
    [address, city, state, country].join(" ")
  end

  def full_address_changed?
    address_changed? || city_changed? || state_changed? || country_changed?
  end

  def email_required?
    false
  end

  private

  def assign_user_role
    self.add_role "user"
  end
end
