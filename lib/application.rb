class Application < ActiveRecord::Base
  belongs_to :user
  belongs_to :job



  #still trying to figure out why this method returns back an array of just the application instances..??
  def self.view_all_for_user(name, email)
    user_applications = self.all.where(user_id: User.find_by(name: name, email_address: email).id)
    user_applications.each do |application|
      puts "Title: #{application.job["title"]}"
      puts "Company: #{application.job["company"]}"
      if application.job["company_url"]
          puts "Company URL: #{application.job["company_url"]}"
      end
      puts "Description: #{application.job["description"]}"
    end
  end
  
end