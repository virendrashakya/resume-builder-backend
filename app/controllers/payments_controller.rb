# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :update, :destroy]

  # GET /payments
  def index
    @payments = current_user.payments
    render json: @payments
  end

  # GET /payments/:id
  def show
    render json: @payment
  end

  # POST /payments
  def create
    @payment = current_user.payments.new(payment_params)
    if @payment.save
      render json: @payment, status: :created
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/:id
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/:id
  def destroy
    @payment.destroy
  end

  private

  def set_payment
    @payment = current_user.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :status, :transaction_id, :payment_method, :subscription_id)
  end
end
