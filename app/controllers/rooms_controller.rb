class RoomsController < ApplicationController
  def index
  end

  def new
    @room = User.new # TODO: change with the right model
  end

  def show
  end
end
