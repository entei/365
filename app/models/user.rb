# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  nickname               :string(255)
#  provider               :string(255)
#  url                    :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  has_many :events
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  validates :username, :nickname, presence: true, uniqueness: true
  validates :username, :nickname, length: {minimum: 4, maximum: 64}
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,  :omniauth_providers => [:facebook, :vkontakte]
   
   
   # Find facebook user by her page url or create new
   def self.find_for_facebook_oauth access_token
   		if user = User.where(:url => access_token.info.urls.Facebook).first
   			user
   		else
   			User.create!(:provider => access_token.provider, 
   				:url => access_token.info.urls.Facebook, 
   				:username => access_token.extra.raw_info.name,
   				:nickname => access_token.extra.raw_info.username,
   				:email => access_token.extra.raw_info.email, 
   				:password => Devise.friendly_token[0,20]) 
   		end
   end      
end
