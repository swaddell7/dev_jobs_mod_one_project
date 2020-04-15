class CommandInterface < ActiveRecord::Base
  def self.welcome_message
    <<~NOTE
      How can we help you today? Enter one of the folloing:
      Search & Apply For Jobs
      View & Delete Applications
      Edit Account Info
    NOTE
  end

  def self.search_jobs(programming_language, city)
    # Lists jobs filtered by programming_language and city
    Job.search_jobs(programming_language, city)

    puts "Would you like to apply to any of the above jobs? Please respond Y or N."
  end

  def main_menu(prompt, account)
    puts "Hi, #{account.name}!"
    prompt.select("Choose one of the following:", ["Search & Apply For Jobs", "View & Delete Applications", "Account Info"])
  end

  # # User should respond Y or N
  # apply_interest = gets.chomp.downcase

  # # If answer is "N" or "n", puts "To perform new search, enter "New" or exit the session with 'exit.'"

  # User indicates whether interested in applying
  # def self.create_application(account, programming_language, city)
  #   puts "Please enter the number corresponding to the job you would like to apply to."

  #   # User enters number, which corresponds to (number - 1) element in the search_jobs array
  #   job_number = gets.chomp

  #   # User indicates number of job they want from list, returns job instance
  #   def select_job(num, programming_language, city)
  #     num = num.to_i
  #     Job.where(programming_language: language, location: city)[num - 1]
  #   end

  #   selected_job = select_job(job_number, programming_language, city)

  #   # User applies to job (arguement should job instance)/new application is created
  #   Application.create(user_id: account.id, job_id: selected_job.id)

  #   puts "Congratulations, you've applied for the #{selected_job.title} position at #{selected_job.company}!"

  #   puts ""

  #   puts "Would you like to apply to another job?"
  # end

  # Ashley's edits _____________________________________________________________________

  # while user_input != "exit"

  # end

  # puts "\n\n"
  # puts welcome_message
  # user_input = gets.chomp.downcase

  # # User can call their account info (name, email)
  # if user_input == "edit account info"
  #   puts account.name
  #   puts account.email_address
  # end

  # # NOT NECCESSARY IF WELCOME MESSAGE IMPLEMENTED: User prompted with a question: would you like to edit your account info(yes/no)
  # puts "Would you like to edit your account info? Indicate Y or N."
  # edit_account = gets.chomp.downcase

  # # If user selects "yes", then ask "would you like to edit your name or email (choose one)"
  # if edit_account == "y"
  #   puts "Would you like to edit your name or email (choose one)?"
  # end
  # data = gets.chomp.downcase

  # def edit_data(account, data)
  #   if data == "name"
  #     puts "Enter the new name you would like to use."
  #     new_name = gets.chomp
  #     account.name = new_name
  #     account.save
  #     puts "Your name has been updated."
  #   elsif data == "email"
  #     puts "Enter the new email you would like to use."
  #     new_email = gets.chomp
  #     account.email_address = new_email
  #     account.save
  #     puts "Your email address has been updated."
  #   else
  #     puts "Great, we won't make any changes to your account."
  #   end
  # end

  # edit_data(account, data)
  # new_email = gets.chomp
  # account.email_address = new_email

  # if data !=
  #     data = "exit"
  # end
end
