require_relative '../config/environment'

puts "Welcome to the Dev Jobs Portal!"
puts "Please enter your fabulous name."
name = gets.chomp

puts "Please enter your email address."
email = gets.chomp

User.has_account?(name, email) 

puts "Which programming language would you like to get a job in?"
programming_language = gets.chomp

puts "Which city would you like to work in?"
city = gets.chomp

Job.search_jobs(programming_language, city)

