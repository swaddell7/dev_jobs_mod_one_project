require_relative "../config/environment"
require "tty-prompt"

prompt = TTY::Prompt.new
# font = TTY::Font.new
# pastel = Pastel.new

puts "\e[H\e[2J"
puts CommandInterface.render_ascii_art
account = User.verified
user_input = nil

while user_input != "exit"
  def main_menu(prompt, account)
    puts "\e[H\e[2J"
    puts "Hi, #{account.name}... you're going to rock this process!"
    puts ""
    prompt.select("Choose one of the following:", ["Search & Apply For Jobs", "View & Delete Applications", "Account Info", "Log Out"])
  end

  user_input = main_menu(prompt, account)
  puts ""

  case user_input
  when "Search & Apply For Jobs"
    puts "Please specify a programming language to begin your search:"
    programming_language = gets.chomp
    puts ""
    puts "In what city would you like to search for jobs?"
    city = gets.chomp
    puts "\e[H\e[2J"
    puts "Below are all the #{programming_language} jobs in the #{city} area:"
    puts ""
    api_jobs = Job.search_jobs(programming_language, city)
    case api_jobs
    when []
      puts "Sorry, this database does not currently have any available #{programming_language} positions in #{city}."
      sleep(3)
    ## LINES 40-48 LEVERAGE A BACK UP DATABASE (SEEDED DATA)
      # puts "Sorry, this database does not currently have any available #{programming_language} positions in #{city}. You are being re-routed to another database..."
      # puts "\e[H\e[2J"
      # puts "Below are all the #{programming_language} jobs in the #{city} area:"
      # seeded_jobs = Job.search_seed(programming_language, city)
      # case seeded_jobs
      # when []
      #   puts ""
      #   puts "Seems like you're outta luck right now... this database does not currently any available #{programming_language} positions in #{city} either."
      # end
    end
    puts ""
    if api_jobs != [] 
      wants_to_apply = prompt.select("Would you like to apply to any of the above jobs?", %w(Yes No))
    end
    if wants_to_apply == "Yes"
      puts ""
      selected_job = account.apply_to_job(programming_language, city)
      account.create_application(selected_job)
      CommandInterface.congratulate_user_for_application(selected_job)
      wants_to_apply_again = prompt.select("Would you like to apply to another job?", %w(Yes No))
      while wants_to_apply_again == "Yes"
        puts ""
        selected_job = account.apply_to_job(programming_language, city)
        account.create_application(selected_job)
        CommandInterface.congratulate_user_for_application(selected_job)
        wants_to_apply_again = prompt.select("Would you like to apply to another job?", %w(Yes No))
        puts ""
      end
    end
  when "View & Delete Applications"
    CommandInterface.applications_list_header
    show_apps = account.view_applications
    next_step = prompt.select("What would you like to do next?", ["Return to Main Menu", "Delete an Existing Application"])
    case next_step
    when "Delete an Existing Application"
      puts ""
      account.delete_application
      sleep(2)
      puts ""
      delete_another = prompt.select("What would you like to do next?", ["Return to Main Menu", "Delete Another Application"])
      while delete_another == "Delete Another Application"
        CommandInterface.applications_list_header
        show_apps
        puts ""
        account.delete_application
        sleep(2)
        puts ""
        delete_another = prompt.select("What would you like to do next?", ["Return to Main Menu", "Delete Another Application"])
        puts ""
      end
    end
  when "Account Info"
    puts "\e[H\e[2J"
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
        account.change_name
        sleep(2)
      when "Email"
        account.change_email
        sleep(2)
      end
    when "No"
      puts "Great, we won't make any changes to your account."
      sleep(2)
    end
  when "Log Out"
    user_input = "exit"
  end
end
