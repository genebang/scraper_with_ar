require_relative '../app/models/grouphug'
require_relative './grouphug_scraper'

module GrouphugImporter
  def self.import
    field_names = ['key', 'confession']
    page_number = 0
    100.times do 
      if page_number == 0
        scraper_deluxe = GrouphugScraper.new('http://web.archive.org/web/20071025014638/http://grouphug.us/')
      else
        scraper_deluxe = GrouphugScraper.new("http://web.archive.org/web/20071025014638/http://grouphug.us/page/#{page_number}/n")
      end
      grouphug_data = scraper_deluxe.zipped_conf
      grouphug_data.each do |data|
        attribute_hash = Hash[field_names.zip(data)]
        grouphug = Grouphug.create!(attribute_hash)
      end
      page_number += 10
    end
  end
end
