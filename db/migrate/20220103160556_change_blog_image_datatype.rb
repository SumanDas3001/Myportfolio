class ChangeBlogImageDatatype < ActiveRecord::Migration[5.2]
  def change
    change_column :blogs, :image, :text
  end
end
