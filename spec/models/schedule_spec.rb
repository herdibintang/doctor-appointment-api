require 'rails_helper'

RSpec.describe Schedule, :type => :model do
  describe "Validations" do
    it { should validate_presence_of(:started_at) }
  end
  
  describe "Associations" do
    it { should belong_to(:doctor).without_validating_presence }
    it { should belong_to(:hospital).without_validating_presence }
  end
end