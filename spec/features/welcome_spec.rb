require 'rails_helper'

RSpec.feature "Welcome", type: :feature do
  scenario "Shows welcome message" do
    visit(root_path)
    expect(page).to have_content("Welcome")
  end

  scenario "Verify link for register of magical land" do
    visit(root_path)
    # expect(page).to have_selector("ul li a")
    # expect(page).to have_link("Register magical land")
    # Refactor
    expect(find("ul li")).to have_link("Register magical land")
  end
end
