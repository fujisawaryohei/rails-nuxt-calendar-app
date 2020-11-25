class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :content
      t.boolean :is_done, default: false
      t.date :date
      t.time :time
      t.timestamps
    end
  end
end
