require 'rails_helper'

RSpec.describe 'sign_in process', type: :feature do
  before do
    create :user, username: 'Bob', email: 'bob@gmail.com', password: 'password'
    Action.create(action_type: 'user_sign_in')
    Action.create(action_type: 'navigation')
    visit '/users/sign_in'
  end

  def login_via_form(email, password)
    within(".new_user") do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
    end
    click_button 'Log in'
  end

  scenario "Signing in with correct credentials" do
    login_via_form('bob@gmail.com', 'password')
    expect(page).to have_content 'Signed in successfully'
  end

  scenario "Signing in with incorrect credentials" do
    login_via_form('other@example.com', 'other')
    expect(page).to have_content 'Invalid Email or password'
  end

  # scenario 'After 3 incorrect password entries the user will see recaptcha' do
  #   4.times do
  #     login_via_form('bob@gmail.com', 'other')
  #   end
  #   expect(page).to have_content 'I\'m not a robot'
  # end

  scenario "logged in user goes to categories page" do
    login_via_form('bob@gmail.com', 'password')
    expect(page).to have_current_path '/categories?locale=en'
  end

end
