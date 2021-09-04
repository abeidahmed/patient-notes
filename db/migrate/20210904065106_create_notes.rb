class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.belongs_to :patient, null: false, foreign_key: true
      t.string :poc

      t.timestamps
    end
  end
end
