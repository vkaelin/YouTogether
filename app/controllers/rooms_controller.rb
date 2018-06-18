class RoomsController < ApplicationController
  def index
    @footer = true
  end

  def new
    @room = User.new # TODO: change with the right model
  end
end
