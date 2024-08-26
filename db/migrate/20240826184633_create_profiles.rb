class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :contact_details
      t.text :education
      t.text :experience
      t.text :skills

      t.timestamps
    end
  end
end
