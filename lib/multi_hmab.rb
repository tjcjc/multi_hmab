module MultiHmab
  # Your code goes here...
end
require 'multi_hmab/multi_end'
require 'multi_hmab/single_end'

ActiveRecord::Base.send(:include, MultiEnd)
ActiveRecord::Base.send(:include, SingleEnd)
