class SearchController < ApplicationController
  def index
    @presenter = SearchPresenter.present(params[:q])
  end
end

class SearchPresenter
  attr_reader :zipcode,
              :stores

  def initialize(zipcode)
    @zipcode = zipcode
    @stores  = Store.near(zipcode)
  end

  def total_stores
    @stores.first.total_stores_nearby
  end

  def self.present(zipcode)
    new(zipcode)
  end
end

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

class BestBuyStoreService
  def get_stores(zipcode)
    @zipcode = zipcode
    # binding.pry
    get_json[:stores].map { |store| store.merge({ total: get_json[:total] }) }
  end

  def self.near(zipcode)
    new.get_stores(zipcode)
  end

  private

    def conn
      @conn ||= Faraday.new("https://api.bestbuy.com/v1/")
    end

    def default_search
      "stores(area(#{@zipcode},25))?format=json&show=city,longName,distance,phone,storeType&pageSize=10&apiKey=#{ENV["best_buy_key"]}"
    end

    def response
      @response ||= conn.get(default_search)
    end

    def get_json
      JSON.parse(response.body, symbolize_names: true)
    end
end
