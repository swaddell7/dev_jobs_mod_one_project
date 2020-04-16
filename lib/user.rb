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

  def self.verified
    puts "Please enter your fabulous name:"
    name = gets.chomp
    puts ""
    puts "Please enter your email address:"
    email = gets.chomp
    puts ""
    self.has_account?(name, email)
    sleep(1)
    puts "\e[H\e[2J"
    self.find_by(name: name, email_address: email)
  end

  def select_job(num, programming_language, city)
    num = num.to_i
    Job.where(programming_language: programming_language, location: city)[num - 1]
  end

  def apply_to_job(programming_language, city)
    puts "Please enter the number corresponding to the job to which you would like to apply:"
    job_number = gets.chomp.to_i
    self.select_job(job_number, programming_language, city)
  end

  def create_application(job)
    Application.create(user_id: self.id, job_id: job.id)
  end

  def account_information
    puts "Your account information:"
    puts "Name: #{self.name}"
    puts "Email: #{self.email_address}"
  end

  def view_applications
    i = 0
    job_ids = self.applications.map { |application| application.job_id }
    jobs_applied = job_ids.map { |id| Job.find_by(id: id) }
    jobs_applied.uniq.each do |job|
      puts "#{i + 1}."
      puts "Title: #{job["title"]}"
      puts "Company: #{job["company"]}"
      puts "Location: #{job["location"]}"
      puts "Programming Language: #{job["programming_language"]}"
      puts "Description: #{job["description"]}"
      puts ""
      i += 1
    end
  end

  def application_ids
    self.applications.map { |application| application.id }
  end

  def delete_application(app_number)
    selected_app_id = self.application_ids[app_number - 1]
    self.applications.delete(selected_app_id)
  end

  # #   puts "Title: #{job["title"]}"
  #   puts "Company: #{job["company"]}"
  #   if application.job["company_url"]
  #     puts "Company URL: #{job["company_url"]}"
  #   end
  #   puts "Location: #{job["location"]}"
  #   puts "Programming Language: #{job["programming_language"]}"
  #   puts "Description: #{job["description"]}"
  # # end

  # def self.view_all_for_user(name, email)
  #   user_applications = self.all.where(user_id: User.find_by(name: name, email_address: email).id)
  #   user_applications.each do |application|
  #     puts "Title: #{application.job["title"]}"
  #     puts "Company: #{application.job["company"]}"
  #     if application.job["company_url"]
  #       puts "Company URL: #{application.job["company_url"]}"
  #     end
  #     puts "Description: #{application.job["description"]}"
  #   end
  # end
  # User can view all their applications

end
