class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout :set_template

    def show 
      authorize @user
    end

    def edit
      authorize @user
    end

    def update
      authorize @user
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @user
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_area_users_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role, :slug, :country, :currency)
    end
  
    def set_template
      case action_name
      when 'show'
          'admin_template'
      else
          'application'
      end
  end


end