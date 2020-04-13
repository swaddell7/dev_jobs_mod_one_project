class User < ActiveRecord::Base
  has_many :applications
  belongs_to :job, through: :application
  
end