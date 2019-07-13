class UsersController < ApplicationController
  include UsersHelper

  before_action :find_user

  def show 
    authorize! :read, @user
  end

  def edit
    authorize! :edit, @user
  end

  def update
    authorize! :update, @user
    
    respond_to do |format|
      if @user.update_attributes user_params
        format.html { redirect_to user_path(@user), notice: 'User successfully updated' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
