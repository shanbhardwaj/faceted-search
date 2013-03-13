class AddValueColumnToLedgers < ActiveRecord::Migration
  def change
  	add_column :retailer_ledgers, :value, :integer, :default => 0
  end
end
