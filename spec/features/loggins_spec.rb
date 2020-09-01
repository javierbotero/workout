require 'rails_helper'

RSpec.feature 'Loggin feature', type: :feature do
  let(:javier) { create(:user) }
  before(:example) { javier }

  feature 'Loggin' do
    scenario 'Unregistered user visits root page and is redirected to loggin page' do
      visit(root_path)
      expect(page).to have_content('Before everything you need to log in')
    end

    scenario 'Registered user loggins' do
      visit(form_loggin_path)
      fill_in('User name', with: 'Javier')
      click_button('Submit')
      expect(page).to have_content('You logged in succesfully')
    end
  end

  feature 'Unregistered user registers' do
    scenario 'User registers' do
      visit(new_user_path)
      fill_in('User name', with: 'Ana')
      click_button('Submit')
      expect(page).to have_content('Your account was created')
    end
  end
end
