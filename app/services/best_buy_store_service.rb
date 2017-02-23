class BestBuyStoreService
  def get_stores(zipcode)
    @zipcode = zipcode
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
