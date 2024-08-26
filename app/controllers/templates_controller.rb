# app/controllers/templates_controller.rb
class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :update, :destroy]

  # GET /templates
  def index
    @templates = Template.all
    render json: @templates
  end

  # GET /templates/:id
  def show
    render json: @template
  end

  # POST /templates
  def create
    @template = Template.new(template_params)
    if @template.save
      render json: @template, status: :created
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /templates/:id
  def update
    if @template.update(template_params)
      render json: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # DELETE /templates/:id
  def destroy
    @template.destroy
  end

  private

  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:name, :description, :preview_image, :content)
  end
end
