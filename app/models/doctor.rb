class Doctor < ActiveRecord::Base
   has_many :appointments
   has_many :patients, through: :appointments

   validates :first_name, presence: true
   validates :surname, presence: true
   validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
   validates :password, presence: true, confirmation: true
   
   has_secure_password
end
