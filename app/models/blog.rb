class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  extend FriendlyId

  friendly_id :title, use: :slugged

  validates_presence_of :title, :body, :topic_id

  belongs_to :topic

  has_many :comments, dependent: :destroy

  has_many :user_favorite_blogs, dependent: :destroy


  def self.recent
    order("created_at DESC")
  end

  def self.search(search)
    if search
      where("lower(title) like ?", "%#{search.downcase}%")
    end
  end

end
