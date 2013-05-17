require 'rake'
require 'rspec/core/rake_task'

$LOAD_PATH.unshift( File.join(File.dirname(__FILE__), 'lib') )

require 'railroad'
 
RSpec::Core::RakeTask.new(:spec) 
 
task :default  => :spec

task :import, [:file] do |f|
  Parser.generate(:file) 
end
