class Api::V1::ItemsController < ApplicationController
  before_action :set_item, except: [:index, :create]

  skip_before_filter :verify_authenticity_token, only: [:create, :destroy]
  respond_to :json

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
