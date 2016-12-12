require 'rails_helper'

RSpec.describe Goal, type: :model do

  describe "validations" do
    it { should validate_presence_of(:user)}
    it { should validate_presence_of(:content)}
  end

  describe "associations" do
    it { should belong_to(:user)}
  end

  describe "#toggle private" do
    let(:goal) { Goal.new }
    it "toggles private from false to true and true to false" do
        goal.toggle_private
        expect(goal.private).to eq(true)
        goal.toggle_private
        expect(goal.private).to eq(false)
    end
  end

  describe "#toggle completed" do
    let(:goal) { Goal.new }
    it "toggles completed from false to true and true to false" do
        goal.toggle_completed
        expect(goal.completed).to eq(true)
        goal.toggle_completed
        expect(goal.completed).to eq(false)
    end
  end
end
