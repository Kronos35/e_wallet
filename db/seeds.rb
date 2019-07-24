require 'factory_bot_rails'

user = FactoryBot.create :user
FactoryBot.create :credit_card, :visa, wallet: user.wallet
FactoryBot.create :credit_card, :mastercard, wallet: user.wallet