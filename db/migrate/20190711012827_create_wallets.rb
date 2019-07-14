class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.references  :user
      t.float       :balance, null: false, default: 0
      t.string      :currency_type, null: false, default: 'usd'
      t.timestamps
    end
  end
end
