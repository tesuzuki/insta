class PicturesController < ApplicationController
  before_action :authenticate_user!
  def index
    @pictures=Picture.all
    @users=User.all
  end

  def new
    @picture=Picture.new
  end

  def create
    upload_file = picture_params[:file]
    picture = {}
    if upload_file != nil 
      picture[:filename] = upload_file.original_filename
      picture[:file] = upload_file.read
    end
    
    picture[:user_id] = picture_params[:user_id]
    picture[:content] = picture_params[:content]
    @picture = Picture.new(picture)
    if @picture.save
      flash[:success] = "画像を保存しました。"
      redirect_to pictures_path
    else
      flash[:error] = "保存できませんでした。"
    end
  end

  def edit
    @picture=Picture.find(params[:id])
  end

  def update
    @picture=Picture.find(params[:id])
    upload_file = picture_params[:file]
    picture = {}
    if upload_file != nil 
      picture[:filename] = upload_file.original_filename
      picture[:file] = upload_file.read
    end 
    picture[:content] = picture_params[:content]
    @picture.update(picture)
    redirect_to pictures_path
  end

  def show
    # send_dataはバイナリファイルをブラウザに表示するため
    # http://railsdoc.com/references/send_data

    @picture = Picture.find(params[:id])
    send_data @picture.file, :type => 'image/jpeg', :disposition => 'inline'
  end

  def destroy
    @picture=Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice:"画像を削除しました。"
  end
  
  private

    def picture_params
      params.require(:picture).permit(
        :filename,:file, :user_id, :content
      )   
    end
end
