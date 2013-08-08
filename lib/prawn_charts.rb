require 'prawn'
require_relative "./prawn_charts/version"

module PrawnCharts
end

Dir["./lib/prawn_charts/data_collectors/**/*.rb"].each {|file| require file }
Dir["./lib/prawn_charts/renderers/**/*.rb"].each {|file| require file }
