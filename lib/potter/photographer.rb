module ActiveRecord
  class Base
    def is_photographer?
      false
    end
  end
end

module Potter
  module Photographer
    extend ActiveSupport::Concern

    included do
      # A photograph is the photograph record of self photographing a photographable record.
      has_many :photographs, :as => :photographer, :dependent => :destroy, :class_name => 'Photograph'

      def is_photographer?
        true
      end

      def photograph!(photographable)
        raise ArgumentError, "#{photographable} is not photographable!" unless photographable.is_photographable?
        raise ArgumentError, "#{self} cannot photograph itself!" unless self != photographable
        Photograph.create!({ :photographer => self, :photographable => photographable }, :without_protection => true)
      end

      def unphotograph!(photographable)
        ff = photographable.photographings.where(:photographer_type => self.class.to_s, :photographer_id => self.id)
        unless ff.empty?
          ff.each { |f| f.destroy }
        else
          raise ActiveRecord::RecordNotFound
        end
      end

      def photographs?(photographable)
        raise ArgumentError, "#{photographable} is not photographable!" unless photographable.is_photographable?
        !self.photographs.where(:photographable_type => photographable.class.to_s, :photographable_id => photographable.id).empty?
      end

      def photographees(klass)
        klass = klass.to_s.singularize.camelize.constantize unless klass.is_a?(Class)
        klass.joins("INNER JOIN photographs ON photographs.photographable_id = #{klass.to_s.tableize}.id AND photographs.photographable_type = '#{klass.to_s}'").
              where("photographs.photographer_type = '#{self.class.to_s}'").
              where("photographs.photographer_id   =  #{self.id}")

      end
    end
  end
end
