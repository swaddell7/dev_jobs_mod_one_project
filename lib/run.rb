puts "Welcome to the Dev Jobs Portal!"
puts "Please enter your email address."
email = gets.chomp

# if User.find_by(email: email)
#     puts "We found your account! For programming language are you looking for a job?"
# else 
#     puts "Doesn't look like we have an account for you yet. Let's get your started. What is your name?"
#     name = gets.chomp
#     User.create(name: name, email: email) 
# end 
