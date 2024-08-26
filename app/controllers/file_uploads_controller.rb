# app/controllers/file_uploads_controller.rb
class FileUploadsController < ApplicationController
  before_action :set_file_upload, only: [:show, :destroy]

  # GET /file_uploads
  def index
    @file_uploads = current_user.file_uploads
    render json: @file_uploads
  end

  # GET /file_uploads/:id
  def show
    render json: @file_upload
  end

  # POST /file_uploads
  def create
    @file_upload = current_user.file_uploads.new(file_upload_params)
    if @file_upload.save
      render json: @file_upload, status: :created
    else
      render json: @file_upload.errors, status: :unprocessable_entity
    end
  end

  # DELETE /file_uploads/:id
  def destroy
    @file_upload.destroy
  end

  private

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:id])
  end

  def file_upload_params
    params.require(:file_upload).permit(:file, :file_type, metadata: {})
  end
end
