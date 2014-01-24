class DropVoteTable < ActiveRecord::Migration
  def up
    drop_table :vote_tables
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end


#http://stackoverflow.com/questions/4020131/rails-db-migration-how-to-drop-a-table
