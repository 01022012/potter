module Potter
  module PlanStore
    extend ActiveSupport::Concern

    included do
      belongs_to :planer,   :polymorphic => true
      belongs_to :planable, :polymorphic => true

      
      validates_presence_of :planable_type, :scope => [:planable_id, :planer_type, :planer_id, :planable_name, :planable_zone, :planable_address, :planable_city, :planable_description, :planable_discount, :planable_reservation_option, :planable_done, :planable_event_date, :planable_removed], :message => 'You cannot make a plan without activities.'

      def self.human_attribute_name(*args); ''; end
    end
  end
end