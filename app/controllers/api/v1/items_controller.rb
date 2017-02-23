class Api::V1::ItemsController < ApplicationController
  before_action :set_item, except: [:index]
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

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
