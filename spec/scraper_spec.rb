require_relative 'spec_helper'

describe Scraper do

  let(:tag) { "javascript" }
  let(:scraper) { Scraper.new }
  let(:scraper2) { Scraper.new(tag) }

  it "is an instance of the Scraper class" do
    scraper.should be_a(Scraper)
  end


  it "should default to the ruby tag" do
    scraper.tag.should eq("ruby")
  end

  it "should accept a tag on initialization" do
    scraper2.tag.should_not eq("ruby")
    scraper2.tag.should eq("javascript")
  end

  it "should have an index url" do
    scraper.index.should eq("http://stackoverflow.com/questions/tagged/ruby?sort=votes&pageSize=50")
    scraper2.index.should eq("http://stackoverflow.com/questions/tagged/#{tag}?sort=votes&pageSize=50")
  end

  context "#scrape" do
    it "should have a scrape method" do
      scraper.should respond_to(:scrape)
    end

    it "should return an array of top-50 thread urls" do
      scraper.scrape.should be_a(Array)
      scraper.scrape.size.should eq(50)
      scraper.scrape.first.should be_a(String)
    end
  end

  context "#make_discussions" do
    it "should create new Discussion instances" do
      Discussion.should_receive(:new).exactly(50).times
      scraper.create_discussions
    end

    it "should create Discussion instances with appropriate urls" do
      scraper.create_discussions
      scraper.discussion_urls.should eq(Discussion.urls)
    end

  end

end