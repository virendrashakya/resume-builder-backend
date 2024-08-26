class CreateAnalyticsData < ActiveRecord::Migration[7.1]
  def change
    create_table :analytics_data do |t|
      t.references :user, null: false, foreign_key: true
      t.string :data_type
      t.json :data

      t.timestamps
    end
  end
end
