class CreateTransactionRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_records do |t|
      t.string      :type
      t.string      :description
      t.string      :amount
      t.references  :wallet

      t.timestamps
    end
  end
end
