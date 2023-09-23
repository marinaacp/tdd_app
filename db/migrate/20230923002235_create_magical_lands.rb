class CreateMagicalLands < ActiveRecord::Migration[7.0]
  def change
    create_table :magical_lands do |t|
      t.string :name
      t.string :universe
      t.string :secret_code
      t.string :deadly
      t.string :picture

      t.timestamps
    end
  end
end
