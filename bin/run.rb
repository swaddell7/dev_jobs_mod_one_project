require_relative '../config/environment'

prompt = TTY::Prompt.new
puts "\e[H\e[2J"
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

# prompt.select("Would you like to submit an application?", %w(Yes No))

Job.search_jobs(programming_language, city)

