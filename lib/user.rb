class User < ActiveRecord::Base
  has_many :applications
  has_many :jobs, through: :applications

  def self.new_account(name, email)
    User.create(name: name, email_address: email)
  end 
  
  def self.has_account?(name, email)
      if self.find_by(name: name, email_address: email)
          puts "We found your account. Welcome back, #{name}!"
      else 
          self.new_account(name, email)
          puts "Welcome #{name}! Your account has been created."
      end 
  end 

end