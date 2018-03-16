class Moderator < ActiveRecord::Base
	has_secure_password

	has_many :posts

	validates :fullname, presence: true
	validates :username, presence: true, format: {with: /@/, message: 'Is not vallid email!'}
	validates :role, presence: true
	validates :password, presence: true
	
end
