class Topic < ApplicationRecord
  validates_presence_of :title
  has_many :blogs

  scope :find_topic_by_id, -> (topic_id) { find_by(id: topic_id) }

  def self.with_blogs
  	includes(:blogs).where.not(blogs: { id: nil })
  end
end
