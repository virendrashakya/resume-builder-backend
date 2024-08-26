class CreateTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :templates do |t|
      t.string :name
      t.text :description
      t.string :preview_image
      t.text :content

      t.timestamps
    end
  end
end
