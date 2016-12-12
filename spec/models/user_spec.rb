require 'rails_helper'

RSpec.describe User, type: :model do
  

  let(:valid_user) do
    User.new(username: "Joe", password: "password")
  end
  let(:invalid_user) do
    User.new(username: "Joe", password: "pord")
  end



  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password). is_at_least(6) }
  end

  describe "#password=" do
    it "sets a new password" do
      invalid_user.password=("password")
      expect(invalid_user.valid?).to eq(true)
    end

  end
end
