class CreateTargetGroupHierarchies < ActiveRecord::Migration[5.2]
  def change
    create_table :target_group_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :target_group_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "target_group_anc_desc_idx"

    add_index :target_group_hierarchies, [:descendant_id],
      name: "target_group_desc_idx"
  end
end
