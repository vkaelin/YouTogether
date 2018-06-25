class AccountController < ApplicationController
  before_action :ensure_authenticated

  def edit
    @rooms = current_user.rooms.where.not(owner: current_user)
    @owned_rooms = Room.where(owner: current_user)
  end

  def update
    current_user.update(user_params)
    redirect_to(account_path)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar)
  end
end
