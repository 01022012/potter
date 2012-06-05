module ActiveRecord
  class Base
    def is_planer?
      false
    end
  end
end

module Potter
  module Planer
    extend ActiveSupport::Concern

    included do
      # A plan is the plan record (self) planning a planable record.
      has_many :plans, :as => :planer, :dependent => :destroy, :class_name => 'Plan'

      def is_planer?
        true
      end
#,  :name, :zone, :address, :city, :description, :discount, :reservation_option, :done, :event_date, :removed
      def plan!(planable)
        ensure_planable!(planable)
        Plan.create!({ :planer => self, :planable => planable }, :without_protection => true)
      end

      def unplan!(planable)
        mm = planable.planings.where(:planer_type => self.class.to_s, :planer_id => self.id)
        unless mm.empty?
          mm.each { |m| m.destroy }
        else
          raise ActiveRecord::RecordNotFound
        end
      end

      def plans?(planable)
        ensure_planable!(planable)
        !self.plans.where(:planable_type => planable.class.to_s, :planable_id => planable.id).empty?
      end

      def planees(klass)
        klass = klass.to_s.singularize.camelize.constantize unless klass.is_a?(Class)
        klass.joins("INNER JOIN plans ON plans.planable_id = #{klass.to_s.tableize}.id AND plans.planable_type = '#{klass.to_s}'").
              where("plans.planer_type = '#{self.class.to_s}'").
              where("plans.planer_id   =  #{self.id}")
      end

      private
        def ensure_planable!(planable)
          raise ArgumentError, "#{planable} is not planable!" unless planable.is_planable?
        end

    end
  end
end
