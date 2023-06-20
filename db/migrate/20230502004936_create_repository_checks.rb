class CreateRepositoryChecks < ActiveRecord::Migration[7.0]
  def change
    create_table :repository_checks do |t|
      t.string :commit_id
      t.integer :offenses_count
      t.boolean :passed, default: false
      t.references :repository, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
