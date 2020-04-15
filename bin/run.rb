require_relative '../config/environment'

prompt = TTY::Prompt.new
puts "\e[H\e[2J"
puts "Welcome to the Dev Jobs Portal!"
puts "Please enter your fabulous name."
name = gets.chomp

puts "Please enter your email address."
email = gets.chomp

User.has_account?(name, email) 

account = User.find_by(name: name, email_address: email)

puts "Which programming language would you like to get a job in?"
programming_language = gets.chomp

puts "Which city would you like to work in?"
city = gets.chomp

# prompt.select("Would you like to submit an application?", %w(Yes No))

Job.search_jobs(programming_language, city)
puts "Would you like to apply to any of the above jobs? Please respond Y or N."
apply_interest = gets.chomp 

# If answer is "N" or "n", puts "To perform new search, enter "New" or exit the session with 'exit.'" 

# User indicates whether interested in applying 
if apply_interest == "Y" || "y"
    puts "Please enter the number corresponding to the job you would like to apply to."
end 
job_number = gets.chomp

 # User indicates number of job they want from list, returns job instance
def select_job(num, language, city)
    num = num.to_i
    Job.where(programming_language: language, location: city)[num - 1]
end 

selected_job = select_job(job_number, programming_language, city)

# User applies to job (arguement should job instance)/new application is created
# Put this in a method 
Application.create(user_id: account.id, job_id: selected_job.id)

puts "Congratulations, you've applied for the #{selected_job.title} position at #{selected_job.company}!"






# while user_input != "exit"

# end 


# User can call their account info (name, email)
# User prompted with a question: would you like to edit your account info(yes/no)
# If user selects "yes", then ask "would you like to edit your name or email (choose one)"
# 