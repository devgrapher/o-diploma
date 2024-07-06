class CreateDiplomas < ActiveRecord::Migration[6.1]
  def change
    create_table :diplomas do |t|
      t.string :number
      t.string :name
      t.integer :rank
      t.string :course
      t.string :club
      t.integer :cardnumber
      t.string :start
      t.string :finish
      t.string :result
      t.string :category
      t.string :gameclass
      t.timestamps
    end
  end
end
