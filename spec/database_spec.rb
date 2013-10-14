require_relative 'spec_helper'

describe Database do

  let(:database) { Database.new }

  it "is an instance of the Database class" do
    database.should be_a(Database)
  end

end