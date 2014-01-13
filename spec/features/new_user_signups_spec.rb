require 'spec_helper'

describe "NewUserSignups" do
  it "with valid information creates new user" do
    visit new_user_registration_path
    fill_in "Username", with: "test_user"
    fill_in "Password", with: "password"
    fill_in "confirmation", with: "password"
    click_button "Sign up"
    
    User.last.username.should eq "test_user"
  end

  it "with invalid information, display error" do
    visit new_user_registration_path
    fill_in "Username", with: "test_user"
    fill_in "Password", with: "password"
    fill_in "confirmation", with: "mismatch01"
    click_button "Sign up"

    page.should have_content("confirmation doesn't match")
  end
end
