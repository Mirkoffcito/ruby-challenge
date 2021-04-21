class RenameImageToImageData < ActiveRecord::Migration[6.1]
  def change
    rename_column :studios, :image, :image_data
  end
end
