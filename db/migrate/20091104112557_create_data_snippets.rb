class CreateDataSnippets < ActiveRecord::Migration
  def self.up
    create_table :data_snippets do |t|
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :data_snippets
  end
end
