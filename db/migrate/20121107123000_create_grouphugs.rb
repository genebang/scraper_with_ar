require_relative '../config'


class CreateGrouphugs < ActiveRecord::Migration
	def change
		create_table :grouphugs do |posts|
			posts.integer :id
			posts.string :key
			posts.string :confession
		end
	end
end