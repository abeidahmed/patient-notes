class AddPronunciationCountToPracticeWord < ActiveRecord::Migration[6.1]
  def change
    add_column :practice_words, :mispronounced_count, :integer, null: false, default: 0
    add_column :practice_words, :pronounced_count, :integer, null: false, default: 0
  end
end
