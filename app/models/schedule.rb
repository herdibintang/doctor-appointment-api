class Schedule < ApplicationRecord
  validates :started_at, presence: true

  belongs_to :doctor
  belongs_to :hospital
  has_many :appointments
end
