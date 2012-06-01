module ActiveRecord
  class Base
    def is_likeable?
      false
    end
  end
end

module Potter
  module Likeable
    extend ActiveSupport::Concern

    included do
      # A liking is the Like record of the liker liking self.
      has_many :likings, :as => :likeable, :dependent => :destroy, :class_name => 'Like'

      def is_likeable?
        true
      end

      def liked_by?(liker)
        raise ArgumentError, "#{liker} is not a liker!" unless liker.is_liker?
        !self.likings.where(:liker_type => liker.class.to_s, :liker_id => liker.id).empty?
      end
      
       def likes_count #user.likes.count(object)
         self.likings.count
      end

      def likers(klass)
        klass = klass.to_s.singularize.camelize.constantize unless klass.is_a?(Class)
        klass.joins("INNER JOIN likes ON likes.liker_id = #{klass.to_s.tableize}.id AND likes.liker_type = '#{klass.to_s}'").
              where("likes.likeable_type = '#{self.class.to_s}'").
              where("likes.likeable_id   =  #{self.id}")
      end
    end
  end
end
