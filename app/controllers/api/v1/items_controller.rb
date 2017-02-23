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
      render json: status: 204
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
