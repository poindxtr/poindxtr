require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "List Page" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Carlos", email: "carlos@poindxtr.com")
      FactoryGirl.create(:user, name: "Andrew", email: "andrew@poindxtr.com")
      visit users_path
    end

    it { should have_selector("h1", text: "All Users") }
    it { should have_selector("title", text: "All Users") }

    it "should list all users" do
      User.all.each do |user|
        page.should have_selector("li", text: user.name)
      end
    end
  end

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
      before { valid_signup }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email("user@example.com") }

        it { should have_selector("title",  text: user.name) }
        it { should have_success_message("Welcome") }
        it { should have_link("Sign Out", href: signout_path) }
      end
    end
  end

  describe "Edit Page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:submit) { "Save changes" }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    it { should have_selector("h1",     text: "Update your profile") }
    it { should have_selector("title",  text: "Edit User") }
    it { should have_link("change",  href: "http://gavatar.com/emails") }

    describe "with invalid information" do
      before { click_button submit }

      it { should have_selector("title", text: "Edit User") }
      it { should have_content("error") }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@poindxtr.com" }

      before {
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password 
        click_button submit
      }

      it { should have_selector("title",  text: new_name) }
      it { should have_success_message }
      it { should have_link("Sign Out", href: signout_path) }

      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
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
