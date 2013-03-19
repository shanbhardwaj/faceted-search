class CreateRetailertypeFilters < ActiveRecord::Migration
  def change
    create_table :retailertype_filters do |t|

      t.timestamps
    end
  end
end
