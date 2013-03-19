class CreateRegionFilters < ActiveRecord::Migration
  def change
    create_table :region_filters do |t|

      t.timestamps
    end
  end
end
