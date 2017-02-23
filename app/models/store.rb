class Store
  attr_reader :name,
              :city,
              :phone,
              :distance,
              :type,
              :total_stores_nearby

  def initialize(store_attrs)
    @name                = store_attrs[:longName]
    @type                = store_attrs[:storeType]
    @city                = store_attrs[:city]
    @phone               = store_attrs[:phone]
    @distance            = store_attrs[:distance]
    @total_stores_nearby = store_attrs[:total]
  end

  def self.near(zipcode)
    BestBuyStoreService.near(zipcode).map do |store_attrs|
      new(store_attrs)
    end
  end
end
