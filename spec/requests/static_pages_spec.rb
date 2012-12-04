require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_selector("h1", text: "Demo") }
    it { should have_selector("title", text: full_title("") ) }
    it { should_not have_selector("title", text: "Home") }
  end

  describe "Help Page" do
    before { visit help_path }

    it { should have_selector("h1", text: "Help") }
    it { should have_selector("title", text: full_title("Help") ) }
  end

  describe "About Page" do
    before { visit about_path }

    it { should have_selector("h1", text: "About Us") }
    it { should have_selector("title", text: full_title("About Us") ) }
  end

  describe "Contact Page" do
    before { visit contact_path }

    it { should have_selector("h1", text: "Contact") }
    it { should have_selector("title", text: full_title("Contact") ) }
  end

  # describe "GET /static_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get static_pages_index_path
  #     response.status.should be(200)
  #   end
  # end
end
