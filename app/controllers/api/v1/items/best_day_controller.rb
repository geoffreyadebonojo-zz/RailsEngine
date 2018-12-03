class Api::V1::Items::BestDayController < ApplicationController

  def show
    id = Item.find(params[:item_id]).id
    day = Item.best_day(id)
    render json: {"data" => {"attributes" => {"best_day" => day}}}   
  end

end