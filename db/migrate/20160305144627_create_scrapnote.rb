class CreateScrapnote < ActiveRecord::Migration
  def change
    create_table :scrapnotes do |t|
      t.references :user
      t.references :mood
      t.string :content
    end

    add_index :scrapnotes, :user_id
    add_index :scrapnotes, :mood_id
  end
end
