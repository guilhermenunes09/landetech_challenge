class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.string :email
      t.string :mobile_phone
      t.string :resume
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
