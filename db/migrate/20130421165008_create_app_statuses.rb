class CreateAppStatuses < ActiveRecord::Migration
  def up
    create_table :app_statuses do |t|
      t.string :status
      t.text :message
      
      t.timestamps
    end
    add_index :app_statuses, :status
  end

  def down
    remove_index :app_statuses, :column => :status
    drop_table :app_statuses
  end
end
