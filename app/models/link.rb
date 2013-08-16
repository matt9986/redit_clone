class Link < ActiveRecord::Base
  attr_accessible :desc, :sub_id, :title, :url, :user_id
  validates :sub_id, :user_id, :title, :url, presence: true
  validates :url, uniqueness: {scope: :user_id}

  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  belongs_to :sub
  has_many :comments, dependent: :destroy

  has_many :votes, dependent: :destroy

  def score
    self.votes.sum(:value)
  end

  def comments_by_parent
    comment_hash = Hash.new{|hash,key| hash[key] = []}
    comments = self.comments
    comments.each do |comment|
      comment_hash[comment.parent_comment_id] << comment
    end
    comment_hash
  end
end
