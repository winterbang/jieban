class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.integer :user_id
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
