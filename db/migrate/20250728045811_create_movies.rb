class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :description
      t.integer :release_year

      t.timestamps
    end

    add_index :movies, :title
    add_index :movies, :release_year
  end
end
