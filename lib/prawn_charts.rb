require 'prawn'
require_relative "./prawn_charts/version"

module PrawnCharts
end

Dir["./lib/data_collectors/**/*.rb"].each {|file| require file }
Dir["./lib/renderers/**/*.rb"].each {|file| require file }
