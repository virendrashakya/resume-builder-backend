# app/models/payment.rb
class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :subscription
  has_one :invoice, dependent: :destroy

  validates :amount, :status, :transaction_id, :payment_method, presence: true

  after_create :generate_invoice

  def generate_invoice
    Invoice.create(
      user: user,
      payment: self,
      invoice_number: SecureRandom.hex(10),
      amount: amount,
      status: 'pending',
      due_date: Date.today + 30.days
    )
  end
end
