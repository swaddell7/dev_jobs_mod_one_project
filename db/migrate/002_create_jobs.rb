class CreateJobs < ActiveRecord::Migration[5.0]
    def change
      create_table :jobs do |t|
        t.string :title
        t.string :company
        t.string :company_url
        t.string :location
        t.string :programming_language
        t.string :description
      end
    end
  end