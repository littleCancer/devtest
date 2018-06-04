class CreateTargetGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :target_groups do |t|
      t.string :name
      t.string :external_id
      t.integer :parent_id
      t.string :secret_code
      t.references :panel_provider, foreign_key: true

      t.timestamps
    end
  end

  add_index :target_groups, :external_id, unique: true
  add_index :target_groups, :parent_id

end
