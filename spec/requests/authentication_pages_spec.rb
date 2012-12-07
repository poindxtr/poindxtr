require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "sign in" do
    before { visit signin_path }

    it { should have_selector("h1", text: "Sign In") }
    it { should have_selector("title", text: "Sign In") }

    describe "with invalid information" do

      describe "after submission" do
        before { click_button "Sign In" }

        it { should have_selector("title", text: "Sign In") }
        it { should have_error_message("Invalid") }

        describe "when visit another page" do
          before { click_link "Home" }
          it { should_not have_error_message }
        end
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in(user) }

      it { should have_selector("title", text: user.name) }
      it { should have_link("Profile", href: user_path(user)) }
      it { should have_link("Setting", href: edit_user_path(user)) }
      it { should have_link("Sign Out", href: signout_path) }
      it { should_not have_link("Sign In", href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end
    end
  end

  describe "authorization" do
    let(:user) { FactoryGirl.create(:user) }

    describe "for non-signed-in users" do

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector("title", text: "Sign In") }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end
  # describe "GET /authentication_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get authentication_pages_index_path
  #     response.status.should be(200)
  #   end
  # end
end
