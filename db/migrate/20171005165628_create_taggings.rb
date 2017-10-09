class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.belongs_to :event, foreign_key: {on_delete: :cascade}
      t.belongs_to :tag, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
