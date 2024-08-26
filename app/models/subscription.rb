# app/models/subscription.rb
class Subscription < ApplicationRecord
  belongs_to :user
  has_many :payments, dependent: :destroy

  validates :plan, :status, presence: true
  validates :start_date, :end_date, presence: true

  def active?
    status == 'active' && end_date > Date.today
  end

  def subscription_details
    {
      plan: plan,
      status: status,
      start_date: start_date,
      end_date: end_date,
      active: active?
    }
  end
end
