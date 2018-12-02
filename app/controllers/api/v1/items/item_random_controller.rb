class Api::V1::Items::ItemRandomController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.find(rand(100)))    
  end

end