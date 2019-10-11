require 'rails_helper'
include Capybara::Email::DSL

RSpec.describe 'sign_up process', type: :feature do
  let(:attrs) { attributes_for(:user) }
  before do
    create :category_with_image
    Action.create(action_type: 'user_sign_in')
    Action.create(action_type: 'navigation')
  end
  scenario 'registers a new user' do
    visit root_path
    within(".links") do
      click_link "Registration"
    end
    fill_in "Username", with: attrs[:username]
    fill_in "Email", with: attrs[:email]
    fill_in "Password", with: attrs[:password]
    fill_in "Password confirmation", with: attrs[:password]
    click_button "Sign up"
    expect(page).to have_content "A message with a confirmation link has been" \
      " sent to your email address. Please follow the link to activate your" \
      " account."
    expect(page).to have_current_path '/?locale=en'
    open_email(attrs[:email])
    expect(current_email.subject).to eq "Confirmation instructions"
    current_email.click_link "Confirm my account"
    expect(page).to have_content "Your email address has been successfully " \
                                 "confirmed."
    expect(page).to have_content "Your email address has been successfully " \
                                 "confirmed."
    within(".new_user") do
      fill_in 'Email', with: attrs[:email]
      fill_in 'Password', with: attrs[:password]
    end
    click_button 'Log in'
    expect(page).to have_content "Signed in successfully."
  end
  # it "registers a new user" do
  #   visit "/"
  #
  #   click_link "Sign up"
  #
  #   fill_in "Email", with: valid_attributes[:email]
  #   fill_in "Password", with: valid_attributes[:password]
  #   fill_in "Password confirmation", with: valid_attributes[:password]
  #   fill_in "First name", with: valid_attributes[:first_name]
  #   fill_in "Last name", with: valid_attributes[:last_name]
  #   select "United States", from: "Country"
  #   select "New York", from: "State"
  #   select "New York", from: "City"
  #   fill_in "Sangha", with: "My Sangha"
  #   fill_in "Phone number", with: "+1 212-555-0187"
  #   fill_in "Facebook url", with: "http://www.facebook.com/johndoe"
  #   click_button "Sign up"
  #
  #   # The user may only login *after* confirming her e-mail
  #   expect(page).to have_content "A message with a confirmation link has been" \
  #     " sent to your email address. Please follow the link to activate your" \
  #     " account."
  #   expect(page).to have_current_path "/users/sign_in"
  #
  #   # Find email sent to the given recipient and set the current_email variable
  #   # Implemented by https://github.com/DockYard/capybara-email
  #   open_email(valid_attributes[:email])
  #   expect(current_email.subject).to eq "Confirmation instructions"
  #   current_email.click_link "Confirm my account"
  #
  #   expect(page).to have_content "Your email address has been successfully " \
  #                                "confirmed."
  #
  #   login_via_form(valid_attributes[:email],
  #                  valid_attributes[:password])
  #   expect(page).to have_content "Signed in successfully."
  #   expect(page).to be_logged_in(valid_attributes[:first_name])
  # end
end