require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do

    it "should include the page tile" do
      full_title("foo").should =~ /foo/
    end

    it "should include the base tile" do
      full_title("foo").should =~ /Demo/
    end

    it "should no include a bar for home page" do
      full_title("").should_not =~ /\|/
    end
  end
end
