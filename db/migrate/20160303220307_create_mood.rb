class CreateMood < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.string :description
    end
  end
end
