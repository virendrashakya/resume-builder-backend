# app/controllers/invoices_controller.rb
class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update, :destroy]

  # GET /invoices
  def index
    @invoices = current_user.invoices
    render json: @invoices
  end

  # GET /invoices/:id
  def show
    render json: @invoice
  end

  # POST /invoices
  def create
    @invoice = current_user.invoices.new(invoice_params)
    if @invoice.save
      render json: @invoice, status: :created
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/:id
  def update
    if @invoice.update(invoice_params)
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/:id
  def destroy
    @invoice.destroy
  end

  private

  def set_invoice
    @invoice = current_user.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :amount, :status, :due_date)
  end
end
