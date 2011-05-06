require 'active_record/migration'
class MultiHabMigration < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.references :multi_end
      t.references :single_end
    end
  end
end
