require 'rails_helper'

RSpec.feature "Friendships", type: :feature do
describe "the signin process", type: :feature do

  it "signs me in" do
    visit '/users/sign_in' do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid'
  end
end

describe "the signin process", type: :feature do

  it "signs me in" do
    visit '/users/sign_in' do
      fill_in 'Email', with: 'abd3@gmail.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid'
  end
end
end
