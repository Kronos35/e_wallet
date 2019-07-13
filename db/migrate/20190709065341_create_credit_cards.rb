class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.references  :wallet
      t.string      :network
      t.string      :card_number
      t.string      :expiration_date
      t.timestamps
    end
  end
end
