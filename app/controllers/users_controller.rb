class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout :set_layout

    def index
      @page_title = "Users"
      @users = User.all.order(last_sign_in_at: :asc)
      @free_users = User.free_user
      @paid_users = User.paid_user
      @editors = User.editor
      @managers = User.manager
      @admins = User.admin
      authorize @users
    end
  

    def show
      authorize @user
      @books = @user.books
      @old_sample_developmental_edits = @user.sample_developmental_edits
      @old_developmental_edits = @user.developmental_edits
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
        format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :name, :email, :role, :slug, :country, :currency, :note, :pen_name)
    end

    def set_side_nav_bar
      @unread_messages = Message.unread
      @unprocessed_developmental_edits = DevelopmentalEdit.developmental_edit_submitted
      @unprocessed_sample_developmental_edits = SampleDevelopmentalEdit.sample_developmental_edit_submitted
    end
    
    def set_layout
      case action_name
      when 
          'page_templates/page_small'
      when 'index', 'show', 'edit'
          'page_templates/page_medium'
      when 
          'page_templates/page_large'
      else
        'application'
      end
    end

end