class Api::V1::ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  before_action :set_item, except: [:index, :create]

  def index
    render json: Item.all
  end

  def show
    render json: @item
  end

  def destroy
    if @item.destroy!
      render json: "Successfully deleted", status: 204
    else
      render json: @item.errors.full_messages.join(", ")
    end
  end

  def create
    binding.pry
    item = Item.new(item_params)
    if item.save!
      render json: item, status: 201
    else
      render json: item.errors.full_messages.join(", ")
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :image_url)
  end
end
