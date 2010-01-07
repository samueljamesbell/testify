require 'digest/sha1'
class User < ActiveRecord::Base
	has_many :reviews
	#  to limit reviews, add :limit => x below
	has_many :limited_reviews, :class_name => 'Review', :foreign_key => 'user_id', :order => 'created_at desc'
	has_many :demands

  acts_as_url :handle
  
  def ratings_options
		@ratings_options = ['awful', 'poor', 'average', 'good', 'excellent']
	end
  
  # a comment
  def to_param
  	url
  end
  
	has_attached_file :logo, :styles => { :thumb => '73x74#', :small => '162x162#'}
	
	validates_attachment_presence :logo
	
	validates_presence_of     :email, :name, :handle, :site, :about
	
  validates_uniqueness_of   :email
  validates_uniqueness_of 	:handle
  
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  attr_accessor :password_confirmation, :beta_code

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
  
  
	def time_management_mean
		time_management_sum = reviews.inject(0) {|sum, review| sum += review.time_management}
		if reviews.empty?
			4
		else
			time_management_sum / reviews.length
		end
	end
	
	def customer_service_mean
		customer_service_sum = reviews.inject(0) {|sum, review| sum += review.customer_service}
		if reviews.empty?
			4
		else
			customer_service_sum / reviews.length
		end
	end
	
	def value_for_money_mean
		value_for_money_sum = reviews.inject(0) {|sum, review| sum += review.value_for_money}
		if reviews.empty?
			4
		else
			value_for_money_sum / reviews.length
		end
	end
	
	def quality_of_service_mean
		quality_of_service_sum = reviews.inject(0) {|sum, review| sum += review.quality_of_service}
		if reviews.empty?
			4
		else
			quality_of_service_sum / reviews.length
		end
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
