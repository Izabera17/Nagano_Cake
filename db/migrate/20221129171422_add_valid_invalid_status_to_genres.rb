class AddValidInvalidStatusToGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :genres, :valid_invalid_status, :integer, default: 0
  end
end
