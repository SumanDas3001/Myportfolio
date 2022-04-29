class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  extend FriendlyId

  friendly_id :title, use: :slugged

  validates_presence_of :title, :body, :topic_id

  mount_uploader :image, BlogUploader

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

  def self.find_latest_blog(blog_id)
    where.not(id: blog_id).last(3) rescue []
  end

end
