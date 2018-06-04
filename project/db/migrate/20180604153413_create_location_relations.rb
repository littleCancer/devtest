class CreateLocationRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :location_relations do |t|
      t.integer :location_id
      t.integer :location_group_id

      t.timestamps
    end

    add_index :location_relations, :location_id
    add_index :location_relations, :location_group_id
    add_index :location_relations, [:location_id, :location_group_id], unique: true

  end
end
