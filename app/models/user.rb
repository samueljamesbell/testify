require 'digest/sha1'
class User < ActiveRecord::Base
	has_many :reviews
	has_many :demands

  acts_as_url :handle
  
  def to_param
  	url
  end

	#has_attached_file :logo, :styles => { :thumb => '100x100', :small => '250x250>'}
	
	validates_presence_of     :email
	validates_presence_of     :name
	
  validates_uniqueness_of   :email
  validates_uniqueness_of 	:handle
  
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validate :password_non_blank
  
    def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

private

  def password_non_blank
    errors.add(:password, "Missing password" ) if hashed_password.blank?
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "estate" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
	
end
