require '../lib/grouphug_scraper'
require 'nokogiri'
require 'open-uri'
require 'fakeweb'

FakeWeb.register_uri(:get, 'http://web.archive.org/web/20071025014638/http://grouphug.us/', :body => "./grouphug_test.html")


describe "nokogiri extracts data from grouphug and spits it in an array" do
let(:scraper) { GrouphugScraper.new('http://web.archive.org/web/20071025014638/http://grouphug.us/') }


  context "nokogiri instanciates correctly" do

    it "initiates with an empty confessions array" do
      scraper.confessions.count.should eq 0
    end

    it "initiates with an empty ids array" do
      scraper.ids.count.should eq 0
    end

    it "initializes with an empty title" do
      scraper.title.should be_empty
    end

    it "assigns a nokogiri object to 'doc'" do
      # scraper.stub(:doc).and_return (Nokogiri::HTML(open('http://web.archive.org/web/20071025014638/http://grouphug.us/')))
      scraper.doc.should be_a_kind_of(Nokogiri::HTML::Document)
    end

  end


  context "nokogiri titlizer returns correct title" do

    it "assigns to the instance variable 'title' the correct title" do
      scraper.titlizer.should eql('group hug // anonymous online confessions')
    end

  end

  context "#scrape_confessions" do
    it "adds a confession to the confessions array" do
      expect { scraper.scrape_confessions }.to change(scraper.confessions, :count).by 10
    end
  end

  context "#scrape_ids" do
    it "scrapes the ids from the document" do
      expect { scraper.scrape_ids }.to change(scraper.ids, :count).by 10
    end
  end


  describe "tests that require scrapes" do
    before :each do
      scraper.scrape_confessions
      scraper.scrape_ids
    end

    context "#zipped_conf" do
      it "gives us a nested array" do
        scraper.zipped_conf.count.should eq(10)
        scraper.zipped_conf.first.count.should eq 2
        scraper.zipped_conf.first.first.should eq '607627449'
      end
    end

    context "#nice_print" do
      it "prints the confessions out in a nice form" do
        STDOUT.should_receive(:puts).exactly(10).times
        scraper.nice_print
      end

    end
  end
end









