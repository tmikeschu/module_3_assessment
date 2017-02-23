module StoresHelper
  def store_name(store)
    "Store: #{store.name}"
  end

  def store_city(store)
    "City: #{store.city}"
  end

  def store_type(store)
    "Store Type: #{store.type}"
  end

  def store_distance(store)
    "Distance: #{store.distance} miles"
  end

  def store_phone(store)
    "Phone: #{store.phone}"
  end
end
