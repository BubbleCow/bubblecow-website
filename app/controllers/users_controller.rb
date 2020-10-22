class UsersController < ApplicationController
    before_action :set_user, only: [:show]

    def show 
      authorize @user
      @user = User.find(params[:id])
    end

    def edit
    end

    def update
        respond_to do |format|
          if @user.update(user_params)
            format.html { redirect_to user_path(@user), notice: 'User was successfully saved.' }
            
          else
            format.html { render :edit }
          end
        end
      end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit()
    end
end