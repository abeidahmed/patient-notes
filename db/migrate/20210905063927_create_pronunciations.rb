class CreatePronunciations < ActiveRecord::Migration[6.1]
  def change
    create_table :pronunciations do |t|
      t.belongs_to :practice_word, null: false, foreign_key: true
      t.integer :result

      t.timestamps
    end

    add_index :pronunciations, :result
  end
end
