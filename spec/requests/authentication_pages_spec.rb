require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "Sign In Page" do
    before { visit signin_path }

    it { should have_selector("h1", text: "Sign In") }
    it { should have_selector("title", text: "Sign In") }

    describe "with invalid information" do

      describe "after submission" do
        before { click_button "Sign In" }

        it { should have_selector("title", text: "Sign In") }
        it { should have_selector("div.alert.alert-error",  text: "Invalid") }

        describe "when visit another page" do
          before { click_link "Home" }

          it { should_not have_selector("div.alert.alert-error") }
        end
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      it { should have_selector("title", text: user.name) }
      it { should have_link("Profile", href: user_path(user)) }
      it { should have_link("Sign Out", href: signout_path) }
      it { should_not have_link("Sign In", href: signin_path) }
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