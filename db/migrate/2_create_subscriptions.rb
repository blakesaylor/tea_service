class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.integer :status
      t.integer :frequency
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
