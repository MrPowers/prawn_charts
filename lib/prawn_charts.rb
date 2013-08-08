require 'prawn'
require_relative "./prawn_charts/version"

module PrawnCharts
end

lib_path = File.expand_path(File.dirname(__FILE__))
Dir["#{lib_path}/prawn_charts/data_collectors/**/*.rb"].each {|file| require file }
Dir["#{lib_path}/prawn_charts/renderers/**/*.rb"].each {|file| require file }
