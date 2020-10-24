class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :schedule
      t.belongs_to :user

      t.timestamps
    end
  end
end
