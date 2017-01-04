class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :subject
      t.string :name
      t.boolean :complete
      t.datetime :completed_at
      t.longtext :task_search

      t.timestamps
    end

    add_index(:tasks, :task_search, type: :fulltext)
  end
end
