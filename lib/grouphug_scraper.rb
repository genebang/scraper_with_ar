require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'yaml'


class GrouphugScraper

  attr_accessor :confessions, :ids, :title, :doc

  def initialize(url)
    @confessions = []
    @ids = []
    @title = ""
    @doc = Nokogiri::HTML(open(url))
  end

  def titlizer
    @title = @doc.at_css("title").text
  end

  def scrape_confessions
    @doc.css("#confessions p").each do |confession|
      @confessions << confession.text.gsub(/\t/, "")
    end
  end

  def scrape_ids
    @doc.css(".conf-id a").each do |id|
      @ids << id.text
    end
  end

  def nice_print
    @ids.zip(@confessions).each do |id, confession|
      puts "#{id} : #{confession}\n"
    end
  end

  def zipped_conf
    scrape_confessions
    scrape_ids
    @ids.zip(@confessions)
  end

  def to_yaml(file_name)
    File.open(file_name, "w") {|f| f.write(zipped_conf.to_yaml)}
    zipped_conf.to_yaml
  end


  def yaml_to_array(input,array)
    array << YAML::load_file(input)  
  end


end



