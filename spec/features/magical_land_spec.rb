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

  context "Registering a new magical land" do
    let(:land_name) { Faker::Fantasy::Tolkien.location }

    scenario "Register a new valid magical land" do # Happy path
      visit(new_magical_land_path)
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
  end

  context "Viewing Magical Lands" do
    let!(:magical_land1) { create_magical_land }
    let!(:magical_land2) { create_magical_land }

    scenario "Shows a land" do
      visit(magical_land_path(magical_land1.id))
      expect(page).to have_content(magical_land1.name)
    end

    scenario "Index shows list of magical lands" do
      visit(magical_lands_path)
      expect(page).to have_content(magical_land1.name).and have_content(magical_land2.name)
    end

    scenario "Click on link show" do
      visit(magical_lands_path)
      click_on("Show", match: :first)
      expect(page).to have_content("Name: #{magical_land1.name}")
    end

    scenario "Click on link edit" do
      visit(magical_lands_path)
      click_on("Edit", match: :first)
      expect(page).to have_content("Edit a magical land")
    end

    scenario "Deletes a magical land" do
      visit(magical_lands_path)
      expect {
        click_on("Delete", match: :first)
      }.to change(MagicalLand, :count).by(-1)
      expect(page).to have_content("Magical land deleted successfully")
    end
  end

  def create_magical_land
    MagicalLand.create!(
      name: Faker::Fantasy::Tolkien.location,
      universe: Faker::Fantasy::Tolkien.location,
      secret_code: Faker::PhoneNumber.phone_number,
      deadly: ["Yes", "No", "Sometimes"].sample,
      picture: "#{Rails.root}/spec/fixtures/magical_land.jpg"
    )
  end
end
