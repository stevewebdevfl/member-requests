class Gprequest < ActiveRecord::Base
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :title, presence: true
end
