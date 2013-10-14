require_relative 'spec_helper'

describe Discussion do

  class TestDiscussion < Discussion
    def get_html
      File.open('spec/fixtures/stackoverflow.html').read
    end
  end

  let(:link) { "http://stackoverflow.com/questions/948135/how-can-i-write-a-switch-statement-in-ruby"}
  let(:topic) { TestDiscussion.new(link) }
  let(:live_topic) { Discussion.new(link) }

  it "should get html" do
    live_topic.get_html.status.should include("200")
  end
  
  it "should be initialized with a url" do
    topic.url.should eq(link)
  end

  it "should get the question from the <title> element" do
    topic.question.should eq("How can I write a switch statement in Ruby?")
  end

  it "should get the upvote count" do
    topic.upvotes.should eq(595)
  end

  it "should get the OP's name" do
    topic.op_name.should eq("Readonly")
  end

  it "should get the OP's profile link" do
    topic.op_link.should eq("http://stackoverflow.com/users/4883/readonly")
  end

  context "database" do
    it "should respond to a save method" do
      Database.should_receive(:save)
      topic.should respond_to(:save)
    end
  end

end