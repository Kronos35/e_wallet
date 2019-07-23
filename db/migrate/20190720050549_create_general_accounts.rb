class CreateGeneralAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :general_accounts do |t|
      t.integer :balance, default: 0
      t.timestamps
    end
  end
end
