class PagesController < ApplicationController
  def index
    @name = params[:name]
  end
end