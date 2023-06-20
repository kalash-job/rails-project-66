class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :owner_name
      t.string :language
      t.integer :github_id
      t.string :clone_url
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamps
      t.index :github_id, unique: true
    end
  end
end
