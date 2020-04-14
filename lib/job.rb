class Job < ActiveRecord::Base
    has_many :applications 
    has_many :users, through: :applications

    def self.search_jobs(language, city)
        self.where(programming_language: language, location: city).each do |job|
            puts "Title: #{job["title"]}"
            puts "Company: #{job["company"]}"
            if job["company_url"]
                puts "Company URL #{job["company_url"]}"
            end
            puts "Description: #{job["description"]}"
            puts "\n\n"
        end
    end

    # def self.print(language, city)
    #     self.search_jobs(language, city)[0]
    # end

end 