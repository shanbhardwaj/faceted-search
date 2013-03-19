class CreateSubregionFilters < ActiveRecord::Migration
  def change
    create_table :subregion_filters do |t|

      t.timestamps
    end
  end
end
