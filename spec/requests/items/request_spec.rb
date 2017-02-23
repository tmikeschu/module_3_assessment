=begin
When I send a GET request to /api/v1/items/1 I receive a 200 JSON response containing the id, name, description, and image_url but not the created_at or updated_at

When I send a DELETE request to /api/v1/items/1 I receive a 204 JSON response if the record is successfully deleted

When I send a POST request to /api/v1/items with a name, description, and image_url I receive a 201 JSON response if the record is successfully created And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at

Verify that your non-GET requests work using Postman or curl. (Hint: ActionController::API). Why doesn't the default ApplicationController support POST and PUT requests?
=end

require "rails_helper"

RSpec.describe "Items API", type: :request do
  it "returns an index of items" do
    create_list(:item, 5)

    get api_v1_items_path

    expect(response.status).to eq 200

    items = JSON.parse(response.body, symbolize_names: true)
    item  = items.first

    expect(items.count).to eq 5
    expect(item).to have_key(:id)
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:image_url)
    expect(item).to_not have_key(:created_at)
    expect(item).to_not have_key(:updated_at)
  end

  it "returns a single item by id" do
    item1, item2 = create_list(:item, 2)

    get api_v1_item_path(item1)

    expect(response.status).to eq 200

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:id]).to eq item1.id
    expect(item).to have_key(:id)
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:image_url)
    expect(item).to_not have_key(:created_at)
    expect(item).to_not have_key(:updated_at)
  end
end
