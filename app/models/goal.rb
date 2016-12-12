class Goal < ActiveRecord::Base
  validates :user, :content, presence: true

  belongs_to :user

  def toggle_private
    self.toggle(:private)
  end

  def toggle_completed
    self.toggle(:completed)
  end
end
