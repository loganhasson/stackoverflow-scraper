require 'nokogiri'
require 'open-uri'
require_relative 'database'

class Discussion

  attr_reader :url, :question, :noko_doc, :upvotes, :op_name, :op_link

  @@urls = []

  def initialize(url)
    @url = url
    @@urls << url
    set_default_values
    save
  end

  def self.urls
    @@urls
  end

  def set_default_values
    @noko_doc = create_noko_doc
    @question = get_question
    @upvotes = get_upvotes
    @op_name = get_op_name
    @op_link = get_op_link
  end

  def create_noko_doc
    Nokogiri::HTML(get_html)
  end

  def get_html
    puts "original one"
    open(self.url)
  end

  def get_question
    self.noko_doc.css('#question-header a').text
  end

  def get_upvotes
    self.noko_doc.at_css('.vote-count-post').text.to_i
  end

  def get_op_name
    self.noko_doc.css('.owner .user-details a').text
  end

  def get_op_link
    "http://stackoverflow.com#{self.noko_doc.css('.owner .user-details a').attr('href')}"
  end

  def save
    Database.save(self)
  end

end