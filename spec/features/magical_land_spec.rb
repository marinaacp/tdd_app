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

  scenario "Register e a new valid magical land" do # Happy path
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

  scenario "Try to register wrongly a new magical land" do # Sad path
    visit(new_magical_land_path)

    click_on("Register land")

    expect(page).to have_content("Field can't be blank")
  end

  scenario "Shows a land" do
    magical_land = MagicalLand.create!(
      name: Faker::Fantasy::Tolkien.location,
      universe: Faker::Fantasy::Tolkien.location,
      secret_code: Faker::PhoneNumber.phone_number,
      deadly: ["Yes", "No", "Sometimes"].sample,
      picture: "#{Rails.root}/spec/fixtures/magical_land.jpg"
    )

    visit(magical_land_path(magical_land.id))
    expect(page).to have_content(magical_land.name)
  end

  scenario "Index shows list of magical lands" do
    magical_land1 = MagicalLand.create!(
      name: Faker::Fantasy::Tolkien.location,
      universe: Faker::Fantasy::Tolkien.location,
      secret_code: Faker::PhoneNumber.phone_number,
      deadly: ["Yes", "No", "Sometimes"].sample,
      picture: "#{Rails.root}/spec/fixtures/magical_land.jpg"
    )

    magical_land2 = MagicalLand.create!(
      name: Faker::Fantasy::Tolkien.location,
      universe: Faker::Fantasy::Tolkien.location,
      secret_code: Faker::PhoneNumber.phone_number,
      deadly: ["Yes", "No", "Sometimes"].sample,
      picture: "#{Rails.root}/spec/fixtures/magical_land.jpg"
    )

    visit(magical_lands_path)
    expect(page).to have_content(magical_land1.name).and have_content(magical_land2.name)
  end
end
