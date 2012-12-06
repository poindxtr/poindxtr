require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "Profile Page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector("h1",     text: user.name) }
    it { should have_selector("title",  text: user.name) }
  end

  describe "Sign Up Page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it { should have_selector("h1",     text: "Sign Up") }
    it { should have_selector("title",  text: "Sign Up") }

    describe "with invalid information" do

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector("title", text: "Sign Up") }
        it { should have_content("error") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email("user@example.com") }

        it { should have_selector("title",  text: user.name) }
        it { should have_selector("div.alert.alert-success",  text: "Welcome") }
        it { should have_link("Sign Out") }
      end
    end
  end
  # describe "GET /user_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get user_pages_index_path
  #     response.status.should be(200)
  #   end
  # end
end
