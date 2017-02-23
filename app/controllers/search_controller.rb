class SearchController < ApplicationController
  def index
    @presenter = SearchPresenter.present(params[:q])
  end
end


