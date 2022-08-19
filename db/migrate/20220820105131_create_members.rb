class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.integer :status, null: false
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.index :status
      t.index %w[status group_id user_id]
      t.index %w[group_id user_id], unique: true

      t.timestamps
    end
  end
end
