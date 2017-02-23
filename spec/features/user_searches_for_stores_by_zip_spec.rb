require "rails_helper"

RSpec.describe do
  context "User" do
    describe "can search for stores by zip" do
      scenario "and see the stores near that zip" do
        VCR.use_cassette "80202 stores" do
          visit root_path

          fill_in :q, with: 80202
          click_on "search"

          expect(current_path).to eq "/search"

          expect(page).to have_content "Stores within 25 miles of 80202"
          expect(page).to have_content "16 Total Stores"
          expect(page).to have_selector(".store", count: 10)

          expect(page).to have_content "City: DENVER"
          expect(page).to have_content "Store: BEST BUY MOBILE - CHERRY CREEK SHOPPING CENTER"
          expect(page).to have_content "Distance: 3.45 miles"
          expect(page).to have_content "Phone: 303-270-9189"
          expect(page).to have_content "Store Type: Mobile SAS"
        end
      end
    end
  end
end
