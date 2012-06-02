module ActiveRecord
  class Base
    def is_photographable?
      false
    end
  end
end

module Potter
  module Photographable
    extend ActiveSupport::Concern

    included do
      # A photographing is the Photograph record of the photographer to self.
      has_many :photographings, :as => :photographable, :dependent => :destroy, :class_name => 'Photograph'

      def is_photographable?
        true
      end

      def photographed_by?(photographer)
        raise ArgumentError, "#{photographer} is not a photographer!" unless photographer.is_photographer?
        !self.photographings.where(:photographer_type => photographer.class.to_s, :photographer_id => photographer.id).empty?
      end

      def photographers(klass)
        klass = klass.to_s.singularize.camelize.constantize unless klass.is_a?(Class)
        klass.joins("INNER JOIN photographs ON photographs.photographer_id = #{klass.to_s.tableize}.id AND photographs.photographer_type = '#{klass.to_s}'").
              where("photographs.photographable_type = '#{self.class.to_s}'").
              where("photographs.photographable_id   =  #{self.id}")
      end
    end
  end
end
