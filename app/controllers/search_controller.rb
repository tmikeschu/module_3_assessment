class SearchController < ApplicationController
  def index
    @presenter = SearchPresenter.present(params[:q])
  end
end

class SearchPresenter
  attr_reader :zipcode

  def initialize(zipcode)
    @zipcode = zipcode
    @stores  = Store.near(zipcode)
  end

  def stores_count
    @stores.count
  end

  def self.present(zipcode)
    new(zipcode)
  end
end

class Store
  def initialize(store_attrs)
    @name     = store_attrs[:longName]
    @type     = store_attrs[:storeType]
    @city     = store_attrs[:city]
    @phone    = store_attrs[:phone]
    @distance = store_attrs[:distance]
  end

  def self.near(zipcode)
    BestBuyStoreService.near(zipcode).each do |store|
      new(store)
    end
  end
end

class BestBuyStoreService
  def self.near(zipcode)

  end
end
