class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references :user
      t.integer :balance, null: false, default: 0
      t.timestamps
    end
  end
end
