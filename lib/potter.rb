require 'potter/helper'

module Potter
end

ActiveRecord::Base.send :include, Potter::Helper