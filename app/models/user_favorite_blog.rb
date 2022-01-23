class UserFavoriteBlog < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :blog, optional: true
end
