class Create<%= message_plural_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= message_plural_name %> do |t|
      t.string :title
      t.string :content
      t.boolean :visible
      t.integer :<%= user_singular_name %>_id
      t.timestamps
    end
  end

  def self.down
    drop_table :<%= message_plural_name %>
  end
end
