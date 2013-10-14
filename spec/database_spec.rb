require_relative 'spec_helper'

describe Database do

  it "has an ATTRIBUTES constant" do
    Database::ATTRIBUTES.should be_a(Hash)
  end

end