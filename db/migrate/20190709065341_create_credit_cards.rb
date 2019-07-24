class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.references  :wallet
      t.string      :card_number
      t.string      :encrypted_card_number
      t.string      :encrypted_card_number_iv
      t.string      :cvv
      t.string      :encrypted_cvv
      t.string      :encrypted_cvv_iv
      t.string      :brand
      t.integer     :year
      t.integer     :month
      t.timestamps
    end
  end
end
