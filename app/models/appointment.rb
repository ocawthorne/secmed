class Appointment < ActiveRecord::Base
   belongs_to :doctor
   belongs_to :patient

   validates :patient_id, presence: true
   validates :diagnosis, presence: true
   validates :date, presence: true
end
