require 'prawn'
require_relative "./prawn_charts/version"

module PrawnCharts
end

lib_path = File.expand_path(File.dirname(__FILE__))
Dir["#{lib_path}/prawn_charts/*.rb"].each {|file| require file }
