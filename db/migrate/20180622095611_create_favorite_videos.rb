class CreateFavoriteVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_videos do |t|
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
