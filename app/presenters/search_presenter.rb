class SearchPresenter
  attr_reader :stores

  def initialize(zipcode)
    @zipcode = zipcode
    @stores  = Store.near(zipcode)
  end

  def zipcode
    "Stores within 25 miles of #{@zipcode}"
  end

  def total_stores
    "#{@stores.first.total_stores_nearby} Total Stores"
  end

  def self.present(zipcode)
    new(zipcode)
  end
end
