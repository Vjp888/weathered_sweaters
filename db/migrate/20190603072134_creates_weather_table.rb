class CreatesWeatherTable < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.text :city_name
      t.float :latitude
      t.float :longitude
      t.jsonb :weather

      t.timestamps
    end
  end
end
