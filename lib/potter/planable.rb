module ActiveRecord
  class Base
    def is_planable?
      false
    end
  end
end

module Potter
  module Planable
    extend ActiveSupport::Concern

    included do
      
      has_many :planings, :as => :planable, :dependent => :destroy, :class_name => 'Plan'

      attr_accessor :planable_name, :planable_zone, :planable_address, :planable_city, :planable_description, :planable_discount, :planable_reservation_option, :planable_done, :planable_event_date, :planable_removed
      def is_planable?
        true
      end

      def planed_by?(planer)
        raise ArgumentError, "#{planer} is not a planer!" unless planer.is_planer?
        !self.planings.where(:planer_type => planer.class.to_s, :planer_id => planer.id).empty?
      end

      def planers(klass)
        klass = klass.to_s.singularize.camelize.constantize unless klass.is_a?(Class)
        klass.joins("INNER JOIN plans ON plans.planer_id = #{klass.to_s.tableize}.id AND plans.planer_type = '#{klass.to_s}'").
              where("plans.planable_type = '#{self.class.to_s}'").
              where("plans.planable_id   =  #{self.id}")
      end

    end
  end
end