module MultiHmab
  # Your code goes here...
end
require File.dirname(__FILE__) + 'multi_hmab/multi_end'
require File.dirname(__FILE__) +'multi_hmab/single_end'

ActeiveRecord::Base.send(:include, MultiEnd)
ActeiveRecord::Base.send(:include, SingleEnd)
