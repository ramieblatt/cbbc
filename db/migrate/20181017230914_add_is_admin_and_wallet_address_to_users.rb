class AddIsAdminAndWalletAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_admin, :boolean, null: false, default: false, index: true
    add_column :users, :wallet_address, :string, index: true
  end
end
