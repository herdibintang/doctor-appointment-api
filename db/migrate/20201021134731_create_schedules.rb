class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.belongs_to :doctor
      t.belongs_to :hospital
      t.datetime :started_at

      t.timestamps
    end
  end
end
