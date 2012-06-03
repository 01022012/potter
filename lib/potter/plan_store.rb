module Potter
  module PlanStore
    extend ActiveSupport::Concern

    included do
      belongs_to :planer,   :polymorphic => true
      belongs_to :planable, :polymorphic => true

      validates_presence_of :planable_type, :scope => [:planable_id, :planer_type, :planer_id, :name, :zone, :address, :city, :description, :discount, :reservation_option, :done, :event_date, :removed], :message => 'You cannot make a plan without activities.'

      def self.human_attribute_name(*args); ''; end
    end
  end
end