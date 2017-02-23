class SearchController < ApplicationController
  def index
    @presenter = Presenter.present(params[:q])
  end
end
