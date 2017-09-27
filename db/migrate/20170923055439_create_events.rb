class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, null: false, default: ''
      t.text :description
      t.string :frequency, null: false, default: 'once' #once, every day, every week, every month
      t.integer :user_id
      t.datetime :start_date 
      t.datetime :finish_date 

      t.references :user, index: true, foreign_key: true 

      t.timestamps
    end
  end
end
