class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :plan
      t.string :status
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
