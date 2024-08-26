class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections do |t|
      t.references :resume, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
