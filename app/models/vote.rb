class Vote < ActiveRecord::Base
  attr_accessible :link_id, :user_id, :value
  validates :user_id, uniqueness: {scope: :link_id}
  validates :user_id, :link_id, :value, presence: true
  validates :value, inclusion: {in: [1, -1]}
  belongs_to :link
end
