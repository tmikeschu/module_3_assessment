require "rails_helper"

RSpec.describe BestBuyStoreService, type: :model do
  context "methods" do
    describe ".near(zipcode)" do
      it "returns an array of store information" do
        VCR.use_cassette("80202 stores") do
          result = BestBuyStoreService.near(80202)
          expected_keys = [:longName, :total, :distance, :phone, :storeType, :city]

          expect(result).to be_an(Array)
          expect(result.all? { |el| el.is_a?(Hash) }).to be true
          result.each do |store|
            expect(store.keys).to match_array(expected_keys)
          end
        end
      end
    end
  end
end
