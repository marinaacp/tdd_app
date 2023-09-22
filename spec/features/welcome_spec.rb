require 'rails_helper'

RSpec.feature "Welcome", type: :feature do
  scenario "Shows welcome message" do
    visit('/') # Root
    expect(page).to have_content("Welcome")
  end
end
