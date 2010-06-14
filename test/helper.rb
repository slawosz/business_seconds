require 'rubygems'

if RUBY_VERSION >= '1.9'
  require 'time'
  require 'date'
  require 'active_support/time'
else
  require 'active_support'
  require 'active_support/core_ext'
end

require 'test/unit'
require 'shoulda'
require 'business_time'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'business_seconds'

#class Test::Unit::TestCase
#end
