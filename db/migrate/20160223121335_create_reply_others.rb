class CreateReplyOthers < ActiveRecord::Migration[5.0]
  def change
    create_table :reply_others do |t|
      t.integer :user_other_id
      t.integer :travel_other_id
      t.text  :content

      t.timestamps
    end
  end
end
