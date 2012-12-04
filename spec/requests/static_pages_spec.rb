require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do

    it "should have the h1 'Demo'" do
      visit root_path
      page.should have_selector("h1", :text => "Demo")
    end

    it "should have the base title 'Demo'" do
      visit root_path
      page.should have_selector("title", :text => "Demo")
    end

    it "should not have the custome title 'Home'" do
      visit root_path
      page.should_not have_selector("title", :text => "Home")
    end
  end

  describe "Help Page" do

    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector("h1", :text => "Help")
    end

    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector("title", :text => "Help")
    end
  end

  describe "About Page" do

    it "should have the h1 'About Us'" do
      visit about_path
      page.should have_selector("h1", :text => "About Us")
    end

    it "should have the title 'About Us'" do
      visit about_path
      page.should have_selector("title", :text => "About Us")
    end
  end

  describe "Contact Page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector("h1", :text => "Contact")
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector("title", :text => "Contact")
    end
  end

  # describe "GET /static_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get static_pages_index_path
  #     response.status.should be(200)
  #   end
  # end
end
