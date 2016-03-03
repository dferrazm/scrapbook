class CreateScrapnote < ActiveRecord::Migration
  def change
    create_table :scrapnotes do |t|
      t.references :user
      t.references :humour
      t.string :content
    end

    add_index :scrapnotes, :user_id
    add_index :scrapnotes, :humour_id
  end
end
