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
      
      def likes_count #n likes / n likings * 100%
        likes = self.likings.where(:dislike => false).count
        unless likes.empty?
         percent_likes = likes / self.likings.count * 100
         percent_likes.to_f
        else
         raise ActiveRecord::RecordNotFound
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
