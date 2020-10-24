class Doctor < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :schedules
end
