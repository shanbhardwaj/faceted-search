class CreateVarietalFilters < ActiveRecord::Migration
  def change
    create_table :varietal_filters do |t|

      t.timestamps
    end
  end
end
