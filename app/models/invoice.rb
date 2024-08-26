# app/models/invoice.rb
class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :payment

  validates :invoice_number, :amount, :status, :due_date, presence: true

  def mark_as_paid
    update(status: 'paid')
  end

  def invoice_details
    {
      invoice_number: invoice_number,
      amount: amount,
      status: status,
      due_date: due_date
    }
  end
end
