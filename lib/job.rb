class Job < ActiveRecord::Base
  has_many :applications
  has_many :users, through: :applications

  def self.api_job_exists?(job, language, city)
    if !self.find_by(title: job["title"], company: job["company"], company_url: job["company_url"], programming_language: language, location: city, description: job["description"])
      self.create(title: job["title"], company: job["company"], company_url: job["company_url"], programming_language: language, location: city, description: job["description"])
    end
  end

  def self.search(language, city)
    results = self.where(programming_language: language, location: city)
  end

  def self.description(job_description)
    description_chunk_index = job_description.index("</p>")
    description_chunk = job_description.chars.take(description_chunk_index).join
    # gsub = description_chunk.gsub!(/(<[^>]*>)|\n|\t/s) {" "}
    # if gsub.length > 50
    #   puts "Description:"
    #   puts gsub
    # else
    #   puts ""
    # end
    description_chunk_without_p_tag = description_chunk.delete("<p>")
    p_tag_index_one = description_chunk.index("<")
    p_tag_index_two = description_chunk.index(">")
    first_part = description_chunk.chars.take(p_tag_index_one).join
    second_part = description_chunk.chars.drop(p_tag_index_two + 1).join
    if (first_part + second_part).length > 100
      puts "Description:"
      puts first_part + second_part
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
      description = Job.description(job["description"])
      puts "\n\n"
      i += 1
    end
  end

## PULLING DATA FROM SEED (IN ADDITION TO API)
  # def self.search_seed(language, city)
  #   i = 0
  #   jobs = self.all.where(programming_language: language, location: city)
  #   jobs.each do |job|
  #     puts "#{i + 1}."
  #     puts "Title: #{job["title"]}"
  #     puts "Company: #{job["company"]}"
  #     if job["company_url"]
  #       puts "Company website: #{job["company_url"]}"
  #     end
  #     puts "Description: #{job["description"]}"
  #     puts "\n\n"
  #     i += 1
  #   end
  # end
end
