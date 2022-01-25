class MailingListsController < ApplicationController
  before_action :set_mailing_list, only: [:show, :edit, :update, :destroy]

  def index
    @mailing_lists = MailingList.all
  end

  def show
  end

  def new
    @mailing_list = MailingList.new
  end

  def edit
  end

  def create
    @mailing_list = MailingList.new(mailing_list_params)
   
    respond_to do |format|
      if @mailing_list.save
        format.html { redirect_to writing_manual_download_path, notice: 'Enjoy!' }
        format.json { render :show, status: :created, location: @mailing_list }
      else
        format.html { render :new }
        format.json { render json: @mailing_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mailing_list.update(mailing_list_params)
        format.html { redirect_to @mailing_list, notice: 'Mailing list was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailing_list }
      else
        format.html { render :edit }
        format.json { render json: @mailing_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mailing_list.destroy
    respond_to do |format|
      format.html { redirect_to mailing_lists_url, notice: 'Mailing list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def writing_manual_download
    @footer = "no footer"
  end

  def writing_manual_pdf_download
    send_file "#{Rails.root}/app/assets/files/writing-manual.pdf", type: "application/pdf", x_sendfile: true
  end


  private

    def set_mailing_list
      @mailing_list = MailingList.find(params[:id])
    end


    def mailing_list_params
      params.require(:mailing_list).permit(:email, :tag)
    end

  
end
