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

  describe "#is_password?" do
    it "returns true if password is correct" do
      expect(valid_user.is_password?("password")).to eq(true)
    end

    it "returns false if password is correct" do
      expect(valid_user.is_password?("passaf=rd")).to eq(false)
    end
  end

  describe '#reset_session_token!' do
    it 'sets a new session token' do
      old_token = valid_user.session_token
      valid_user.reset_session_token!
      expect(valid_user.session_token).not_to eq(old_token)
    end
  end

  describe '::find_by_credentials' do
    it 'returns nil if user does not exist' do
      expect(User.find_by_credentials("Joseph", "password")).to be nil
    end

    it 'returns nil if password does not match' do
      expect(User.find_by_credentials("Joe", "pord")).to be nil
    end

    it 'returns the user if the password' do
      user = User.create(username: 'Billy', password: "Bob Thorton")

      expect(User.find_by_credentials("Billy", "Bob Thorton")).to eq(user)
    end
  end
end
