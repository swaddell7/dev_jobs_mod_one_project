require_relative "../config/environment"

prompt = TTY::Prompt.new

puts "\e[H\e[2J"
puts "Welcome to the Dev Jobs Portal!"
puts ""
puts "Please enter your fabulous name."
name = gets.chomp
puts ""
puts "Please enter your email address."
email = gets.chomp
puts ""
User.has_account?(name, email)
sleep(1)
puts "\e[H\e[2J"
account = User.find_by(name: name, email_address: email)
user_input = nil

while user_input != "exit"
  def main_menu(prompt, account)
    puts "\e[H\e[2J"
    puts "Hi, #{account.name}!"
    prompt.select("Choose one of the following:", ["Search & Apply For Jobs", "View & Delete Applications", "Account Info", "Log Out"])
  end

  user_input = main_menu(prompt, account)

  puts ""
  case user_input

  when "Search & Apply For Jobs"
    puts ""
    puts "Which programming language would you like to get a job in?"
    programming_language = gets.chomp
    puts ""
    puts "Which city would you like to work in?"
    city = gets.chomp
    puts "\e[H\e[2J"
    puts "Below are all the #{programming_language} jobs in the #{city} area:"
    puts ""
    Job.search_jobs(programming_language, city)
    wants_to_apply = prompt.select("Would you like to apply to any of the above jobs?", %w(Yes No))
    case wants_to_apply
    when "Yes"
      puts "Please enter the number corresponding to the job you would like to apply to."

      # User enters number, which corresponds to (number - 1) element in the search_jobs array
      job_number = gets.chomp

      # User indicates number of job they want from list, returns job instance
      selected_job = account.select_job(job_number, programming_language, city)

      # User applies to job (argument is job instance)/new application is created
      account.create_application(selected_job)
      puts ""
      puts "Congratulations, you've applied for the #{selected_job.title} position at #{selected_job.company}!"
      puts ""
      sleep(1)
      wants_to_apply_again = prompt.select("Would you like to apply to another job?", %w(Yes No))
      while wants_to_apply_again == "Yes"
        puts "Please enter the number corresponding to the job you would like to apply to."

        # User enters number, which corresponds to (number - 1) element in the search_jobs array
        job_number = gets.chomp

        # User indicates number of job they want from list, returns job instance
        selected_job = account.select_job(job_number, programming_language, city)

        # User applies to job (argument is job instance)/new application is created
        account.create_application(selected_job)
        puts ""
        puts "Congratulations, you've applied for the #{selected_job.title} position at #{selected_job.company}!"
        puts ""
        sleep(1)
        wants_to_apply_again = prompt.select("Would you like to apply to another job?", %w(Yes No))
        puts ""
      end
    end
  when "View & Delete Applications"
    puts "Meow"
  when "Account Info"
    account.account_information
    puts ""
    change_account_info = prompt.select("Would you like to edit your account information?", %w(Yes No))
    puts ""
    case change_account_info
    when "Yes"
      field = prompt.select("Which field would you like to edit?", %w(Name Email))
      puts ""
      case field
      when "Name"
        puts "Enter the new name you would like to use."
        new_name = gets.chomp
        account.name = new_name
        account.save
        puts ""
        puts "Your name has been updated."
      when "Email"
        puts "Enter the new email you would like to use."
        new_email = gets.chomp
        account.email_address = new_email
        account.save
        puts ""
        puts "Your email address has been updated."
      end
    when "No"
      puts "Great, we won't make any changes to your account."
    end
  when "Log Out"
    user_input = "exit"
  end
end
# def search_and_apply_for_jobs
#   CommandInterface.search_jobs(programming_language, city)
#   user_input = gets.chomp.downcase

#   if user_input.include?("y")
#     # puts "Please enter the number corresponding to the job you would like to apply to."

#     # # User enters number, which corresponds to (number - 1) element in the search_jobs array
#     # job_number = gets.chomp

#     # # User indicates number of job they want from list, returns job instance
#     # selected_job = account.select_job(job_number, programming_language, city)

#     # # User applies to job (arguement should job instance)/new application is created
#     # account.create_application(selected_job)

#     puts "Congratulations, you've applied for the #{selected_job.title} position at #{selected_job.company}!"

#     puts ""

#     puts "Would you like to apply to another job? Select Y or N."
#     user_input = gets.chomp.downcase
#     if user_input == "y"
#       CommandInterface.search_jobs(programming_language, city)
#     else
#       user_input == "exit"
#       return
#     end
#   else
#     puts "To perform a new search, enter 'New' or exit the session with 'Exit.'"
#     user_input = gets.chomp.downcase
#     sleep(3)
#     if user_input == "new"
#       search_and_apply_for_jobs
#     end
#   end
# end

# while user_input.include?("search")
#   search_and_apply_for_jobs
# end

# while user_input.include?("view") && user_input != "exit"
# end
# puts "Which programming language would you like to get a job in?"
# programming_language = gets.chomp

# puts "Which city would you like to work in?"
# city = gets.chomp

# # prompt.select("Would you like to submit an application?", %w(Yes No))

# Job.search_jobs(programming_language, city)
# puts "Would you like to apply to any of the above jobs? Please respond Y or N."
# apply_interest = gets.chomp

# # If answer is "N" or "n", puts "To perform new search, enter "New" or exit the session with 'exit.'"

# # User indicates whether interested in applying
# if apply_interest == "Y" || apply_interest == "y"
#   puts "Please enter the number corresponding to the job you would like to apply to."
# end
# job_number = gets.chomp

# # User indicates number of job they want from list, returns job instance
# def select_job(num, language, city)
#   num = num.to_i
#   Job.where(programming_language: language, location: city)[num - 1]
# end

# selected_job = select_job(job_number, programming_language, city)

# # User applies to job (arguement should job instance)/new application is created
# # Put this in a method
# Application.create(user_id: account.id, job_id: selected_job.id)

# puts "Congratulations, you've applied for the #{selected_job.title} position at #{selected_job.company}!"

# # Ashley's edits _____________________________________________________________________

# # while user_input != "exit"

# # end

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
# # new_email = gets.chomp
# # account.email_address = new_email

# # if data !=
# #     data = "exit"
# # end
