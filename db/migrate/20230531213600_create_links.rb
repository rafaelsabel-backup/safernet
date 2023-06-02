class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url, null: false, limit: 5000
      t.string :domain, null: false
      t.string :tld
      t.string :cctld
      t.string :path, limit: 5000
      t.string :query, limit: 5000
      t.string :fragment
      t.timestamps
    end
  end
end
