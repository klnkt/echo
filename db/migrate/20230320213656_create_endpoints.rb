class CreateEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoints do |t|
      t.integer :id
      t.string :verb
      t.string :path
      t.jsonb :response

      t.timestamps
    end
  end
end
