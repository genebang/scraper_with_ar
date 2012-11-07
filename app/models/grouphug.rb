require_relative '../../db/config'

class Grouphug < ActiveRecord::Base
	validates :key, :uniqueness => true
end