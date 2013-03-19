class CreateWinestyleFilters < ActiveRecord::Migration
  def change
    create_table :winestyle_filters do |t|

      t.timestamps
    end
  end
end
