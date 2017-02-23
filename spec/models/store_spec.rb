require "rails_helper"

RSpec.describe Store do
  it "has expected attributes" do
    VCR.use_cassette("80202 stores") do
      store = Store.near(80202).first

      expect(store).to respond_to(:name)
      expect(store).to respond_to(:city)
      expect(store).to respond_to(:phone)
      expect(store).to respond_to(:distance)
      expect(store).to respond_to(:type)
      expect(store).to respond_to(:total_stores_nearby)
    end
  end
end
