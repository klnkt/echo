class CreateEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoints do |t|
      t.string :verb
      t.string :path
      t.integer :response_code
      t.json :headers
      t.string :body

      t.timestamps

      t.index :verb
      t.index :path
    end
  end
end
