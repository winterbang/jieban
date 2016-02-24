class CreateTravelOthers < ActiveRecord::Migration[5.0]
  def change
    create_table :travel_others do |t|
      t.integer :user_other_id
      t.string  :point_of_departure
      t.string  :destination
      t.date    :date_of_departure
      t.integer :dates
      t.integer :budget
      t.text    :intro

      t.timestamps
    end
  end
end
