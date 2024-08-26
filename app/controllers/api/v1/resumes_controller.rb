# app/controllers/resumes_controller.rb
class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :update, :destroy, :generate_pdf]

  # GET /resumes
  def index
    @resumes = current_user.resumes
    render json: @resumes
  end

  # GET /resumes/:id
  def show
    render json: @resume
  end

  # POST /resumes
  def create
    @resume = current_user.resumes.new(resume_params)
    if @resume.save
      render json: @resume, status: :created
    else
      render json: @resume.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /resumes/:id
  def update
    if @resume.update(resume_params)
      render json: @resume
    else
      render json: @resume.errors, status: :unprocessable_entity
    end
  end

  # DELETE /resumes/:id
  def destroy
    @resume.destroy
  end

  # POST /resumes/:id/generate_pdf
  def generate_pdf
    @resume.generate_pdf
    render json: { message: 'PDF generated successfully' }
  end

  private

  def set_resume
    @resume = current_user.resumes.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:title, :profile_id, :template_id, data: {})
  end
end
