class Job < ActiveRecord::Migration[5.1]
    has_many :applications 
    has_many :users, through: :applications
end 