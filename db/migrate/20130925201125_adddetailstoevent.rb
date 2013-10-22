class Adddetailstoevent < ActiveRecord::Migration
  def change
      add_column :events, :description, :text
      add_column :events, :color, :string
      add_column :events, :place, :string
      add_column :events, :important, :boolean, :default => false
      add_column :events, :notice, :string
  end
end
