class CommandInterface
  def self.render_ascii_art
    File.readlines("lib/ascii.txt") do |line|
      line
    end
  end

  def self.congratulate_user_for_application(job)
    puts ""
    puts "Congratulations, you've applied for the #{job.title} position at #{job.company}!"
    puts ""
    sleep(1)
  end

  def self.applications_list_header
    puts "\e[H\e[2J"
    puts "The following are the jobs for which you've submitted an application:"
    puts ""
  end
end