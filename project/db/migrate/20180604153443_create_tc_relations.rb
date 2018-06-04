class CreateTcRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :tc_relations do |t|
      t.integer :country_id
      t.integer :target_group_id

      t.timestamps
    end

    add_index :tc_relations, :country_id
    add_index :tc_relations, :target_group_id
    add_index :tc_relations, [:country_id, :target_group_id], unique: true

  end
end
