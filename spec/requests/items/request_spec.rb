=begin

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

  it "deletes an item by id number" do
    item1, item2 = create_list(:item, 2)

    delete api_v1_item_path(item1)

    expect(response.status).to eq 204
    expect { Item.find(item1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "creates a new item" do
    item_params = {
      name: "Item",
      description: "A great item",
      image_url: "google.com"
    }

    post api_v1_items_path, item: item_params

    expect(response.status).to eq 201

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:id]).to eq Item.last.id
    expect(item).to have_key(:id)
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:image_url)
    expect(item).to_not have_key(:created_at)
    expect(item).to_not have_key(:updated_at)
  end
end
