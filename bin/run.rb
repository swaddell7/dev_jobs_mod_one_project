require_relative '../config/environment'

puts "Welcome to the Dev Jobs Portal!" "\n"
puts "Please enter your fabulous name."
name = gets.chomp "\n"

puts "Please enter your email address."
email = gets.chomp "\n"
puts ""
User.has_account?(name, email) "\n"

puts "Which programming language would you like to get a job in?"
programming_language = gets.chomp

puts "Which city would you like to work in?"
city = gets.chomp
# self.city = city 

# User.find_by(programming_language: programming_language, location: city)

