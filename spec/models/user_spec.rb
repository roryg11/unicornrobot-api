require 'rails_helper'

#Test suite for user model
RSpec.describe User, type: :model do

  # Validation tests
  # ensure columns email, username, password and created_by are present before saving
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
