require 'active_support/concern'

%w{likeable liker like_store photographable photographer photograph_store planable planer plan_store}.each do |f|
  require "#{File.dirname(__FILE__)}/#{f}"
end

module Potter
  module Helper
    extend ActiveSupport::Concern

    module ClassMethods
      ## Like
      def acts_as_liker(opts = nil)
        include Potter::Liker
      end

      def acts_as_likeable(opts = nil)
        include Potter::Likeable
      end

      def acts_as_like_store(opts = nil)
        include Potter::LikeStore
      end

      ## Album
      def acts_as_photographer(opts = nil)
        include Potter::Photographer
      end

      def acts_as_photographable(opts = nil)
        include Potter::Photographable
      end

      def acts_as_photograph_store(opts = nil)
        include Potter::PhotographStore
      end
      
      ## Plans
      def acts_as_planer(opts = nil)
        include Potter::Planer
      end

      def acts_as_planable(opts = nil)
        include Potter::Planable
      end

      def acts_as_plan_store(opts = nil)
        include Potter::PlanStore
      end
    end
  end
end
