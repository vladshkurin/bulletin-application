class User < ActiveRecord::Base
  rolify

  has_many :messages
  has_many :comments

  after_validation :geocode

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.login = auth.info.nickname
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
end
