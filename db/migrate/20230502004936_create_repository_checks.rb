class CreateRepositoryChecks < ActiveRecord::Migration[7.0]
  def change
    create_table :repository_checks do |t|
      t.integer :commit_id
      t.boolean :passed
      t.references :repository, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
