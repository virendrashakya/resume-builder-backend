class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :activity_type
      t.json :activity_data

      t.timestamps
    end
  end
end
