class Job < ActiveRecord::Base
  has_many :applications
  has_many :users, through: :applications

  def self.api_job_exists?(job, language, city)
    if !self.find_by(title: job["title"], company: job["company"], company_url: job["company_url"], programming_language: language, location: city, description: job["description"])
      self.create(title: job["title"], company: job["company"], company_url: job["company_url"], programming_language: language, location: city, description: job["description"])
    end
  end

  def self.search_jobs(language, city)
    i = 0
    parse_json(language, city).each do |job|
      self.api_job_exists?(job, language, city)
      puts "#{i + 1}."
      puts "Title: #{job["title"]}"
      puts "Company: #{job["company"]}"
      if job["company_url"]
        puts "Company website: #{job["company_url"]}"
      end
      puts "Description: #{job["description"]}"
      puts "\n\n"
      i += 1
    end
  end

  def self.search(language, city)
    results = self.where(programming_language: language, location: city)
  end

  # def self.print
  #     i = 0
  #     results.each do |job|
  #         puts "##{i+1}"
  #         puts "Title: #{job["title"]}"
  #         puts "Company: #{job["company"]}"
  #         if job["company_url"]
  #             puts "Company URL #{job["company_url"]}"
  #         end
  #         puts "Description: #{job["description"]}"
  #         puts "\n\n"
  #         i+=1
  #     end
  # end

  # def self.print(language, city)
  #     self.search_jobs(language, city)[0]
  # end

end
