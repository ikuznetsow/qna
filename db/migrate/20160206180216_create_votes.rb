# rails generate model Vote value:integer user:references:index votable:references{polymorphic}:index
class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, default: 0,  null: false
      t.references :user, index: true, foreign_key: true
      t.references :votable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
