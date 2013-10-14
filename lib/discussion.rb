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
    open(self.url)
  end

  def get_question
    self.noko_doc.css('#question-header a').text
  end

  def get_upvotes
    self.noko_doc.at_css('.vote-count-post').text.to_i
  end

  def get_op_name
    op_name_node = self.noko_doc.css('.owner .user-details a')
    if op_name_node
      op_name_node.text
    else
      "Community Wiki"
    end
  end

  def get_op_link
    op_link_node = self.noko_doc.at_css('.owner .user-details a')
    if op_link_node
      "http://stackoverflow.com#{op_link_node.attr('href')}"
    else
      "Community Wiki"
    end
  end

  def save
    Database.save(self)
  end

  def self.clear_urls
    @@urls.clear
  end

end