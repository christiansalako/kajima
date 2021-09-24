# frozen_string_literal: true

class Host < ApplicationRecord
  has_many :bookings

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
