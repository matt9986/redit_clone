class Sub < ActiveRecord::Base
  attr_accessible :mod_id, :name
  validates :mod_id, :name, presence: true
  validates :name, uniqueness: true

  belongs_to :mod,
    class_name: "User",
    foreign_key: :mod_id,
    primary_key: :id

  has_many :links, dependent: :destroy
end
