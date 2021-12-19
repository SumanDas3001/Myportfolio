class CreateUserFavoriteBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_favorite_blogs do |t|
      t.references :user, foreign_key: true
      t.references :blog, foreign_key: true
      t.boolean :is_favorited, default: false

      t.timestamps
    end
  end
end
