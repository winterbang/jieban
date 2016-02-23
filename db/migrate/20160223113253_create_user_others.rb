class CreateUserOthers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_others do |t|
      t.string  :name
      t.integer :qq
      t.string  :weibo
      t.string  :img_url

    end
  end
end
