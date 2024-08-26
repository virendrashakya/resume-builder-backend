# app/controllers/sections_controller.rb
class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :update, :destroy]

  # GET /sections
  def index
    @sections = Section.where(resume_id: params[:resume_id])
    render json: @sections
  end

  # GET /sections/:id
  def show
    render json: @section
  end

  # POST /sections
  def create
    @section = Section.new(section_params)
    @section.resume_id = params[:resume_id]

    if @section.save
      render json: @section, status: :created
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sections/:id
  def update
    if @section.update(section_params)
      render json: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sections/:id
  def destroy
    @section.destroy
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:title, :content, :position)
  end
end
