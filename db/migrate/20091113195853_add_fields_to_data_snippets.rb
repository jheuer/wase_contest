class AddFieldsToDataSnippets < ActiveRecord::Migration
  def self.up
    add_column :data_snippets, :source, :string
    add_column :data_snippets, :timestamp, :integer
    add_column :data_snippets, :result, :text
  end

  def self.down
    remove_column :data_snippets, :result
    remove_column :data_snippets, :timestamp
    remove_column :data_snippets, :source
  end
end
