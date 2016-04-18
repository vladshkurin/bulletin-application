class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    unless params[:user][:birthday].empty?
      params[:user][:birthday] = DateTime.strptime(params[:user][:birthday], "%d/%m/%Y")
    end
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    end
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :full_name,
      :birthday,
      :address,
      :city,
      :role,
      :state,
      :country,
      :zip,
      :role_ids
    )
  end
end
