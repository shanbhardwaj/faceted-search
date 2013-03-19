class CreateWinetypeFilters < ActiveRecord::Migration
  def change
    create_table :winetype_filters do |t|

      t.timestamps
    end
  end
end
