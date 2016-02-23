class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :travel_id
      t.text  :content
    end
  end
end
