# app/models/token_blacklist.rb

class TokenBlacklist < ApplicationRecord
  validates :jti, presence: true, uniqueness: true
  validates :exp, presence: true
end
