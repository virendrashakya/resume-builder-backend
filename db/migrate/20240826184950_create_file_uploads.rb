class CreateFileUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :file_uploads do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file
      t.string :file_type
      t.json :metadata

      t.timestamps
    end
  end
end
