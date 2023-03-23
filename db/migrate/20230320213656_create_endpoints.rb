class CreateEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoints do |t|
      t.string :verb
      t.string :path
      t.integer :response_code
      t.blob :headers
      t.blob :body

      t.timestamps
    end
  end
end
