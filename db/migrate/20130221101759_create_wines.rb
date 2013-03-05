class CreateWines < ActiveRecord::Migration
  def self.up
    create_table :wines do |t|
      t.integer :producer_id
      t.string :wine_name
      t.string :producer
      t.string :varietal
      t.string :varietal2
      t.string :year
      t.integer :vintage

      t.timestamps
    end
  end

  def self.down
    drop_table :wines
  end
end
