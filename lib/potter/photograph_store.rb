module Potter
  module PhotographStore
    extend ActiveSupport::Concern

    included do
      belongs_to :photographer,   :polymorphic => true
      belongs_to :photographable, :polymorphic => true

      validates_uniqueness_of :photographable_type, :scope => [:photographable_id, :photographer_type, :photographer_id], :message => 'Only one photograph per user.'

      def self.human_attribute_name(*args); ''; end
    end
  end
end
