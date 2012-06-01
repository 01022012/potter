require 'rubygems'
require 'active_record'
require 'mocha'
require 'shoulda'
require 'test/unit'
require 'logger'

$:.push File.expand_path("../lib", __FILE__)
require "potter"

ActiveRecord::Base.configurations = {'sqlite3' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('sqlite3')

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :name
  end

  create_table :movies do |t|
    t.string :name
  end

  create_table :likes do |t|
    t.string  :liker_type
    t.integer :liker_id
    t.string  :likeable_type
    t.integer :likeable_id
    t.datetime :created_at
  end

  create_table :im_a_likers do |t|
    t.timestamps
  end

  create_table :im_a_likeables do |t|
    t.timestamps
  end

  create_table :vanillas do |t|
    t.timestamps
  end
end

class User < ActiveRecord::Base
  acts_as_liker
  acts_as_likeable
end

class Movie < ActiveRecord::Base
  acts_as_likeable
  has_many :comments
end

class Like < ActiveRecord::Base
  acts_as_like_store
end

class ImALiker < ActiveRecord::Base
  acts_as_liker
end

class ImALikeable < ActiveRecord::Base
  acts_as_likeable
end

class Vanilla < ActiveRecord::Base
end
