require 'rails_helper'

RSpec.feature "MagicalLands", type: :feature do
  scenario "Visit link Resgister magical land" do
    visit(root_path)
    expect(page).to have_link("Register magical land")
  end

  scenario "Click on Register magical land and be redirected" do
    visit(root_path)
    click_on("Register magical land")
    expect(page).to have_content("List of magical lands")
    expect(page).to have_link("New magical land")
  end

  scenario "Click on Register magical land and go to a form" do
    visit(magical_lands_path)
    click_on("New magical land")
    expect(page).to have_content("New magical land")
  end

  scenario "Register e a new valid magical land" do
    visit(new_magical_land_path)
    land_name = Faker::Fantasy::Tolkien.location
    fill_in('Name', with: land_name)
    fill_in('Universe', with: Faker::Fantasy::Tolkien.location)
    fill_in('Secret code', with: Faker::PhoneNumber.phone_number)
    attach_file("Picture of the land", "#{Rails.root}/spec/fixtures/magical_land.jpg")
    choose(option: ["Yes", "No", "Sometimes"].sample)
    click_on("Register land")

    expect(page).to have_content("New land successfully registered!")
    expect(MagicalLand.last.name).to eq(land_name)
  end
end
