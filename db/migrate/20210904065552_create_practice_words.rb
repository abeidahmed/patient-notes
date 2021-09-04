class CreatePracticeWords < ActiveRecord::Migration[6.1]
  def change
    create_table :practice_words do |t|
      t.string :name, null: false
      t.string :word_error
      t.text :additional_info
      t.belongs_to :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
