require 'nokogiri'
require 'open-uri'

class Discussion

  attr_reader :url, :question, :noko_doc

  @@urls = []

  def initialize(url)
    @url = url
    @@urls << url
    set_default_values
  end

  def self.urls
    @@urls
  end

  def set_default_values
    @noko_doc = create_noko_doc
    @question = get_question
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

end