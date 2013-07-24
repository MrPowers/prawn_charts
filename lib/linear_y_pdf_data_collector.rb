class LinearYPdfDataCollector
  attr_reader :input_data, :graph_height_pdf, :y_labels
  def initialize(input_data, graph_height_pdf, y_labels)
    @input_data = input_data
    @graph_height_pdf = graph_height_pdf
    @y_labels = y_labels
  end

  def pdf_points_per_unit
    graph_height_pdf / y_labels.max
  end

  def collect
    input_data.inject([]) { |memo, (_, y_units)| memo << y_units * pdf_points_per_unit; memo }
  end
end

#input_data = [["Jan 11", 5], ["Feb 11", 2], ["Mar 11", 12]]
#graph_height_pdf = 160
#y_labels = [0, 4, 8, 12, 16]
#l = LinearYPdfDataCollector.new(input_data, graph_height_pdf, y_labels)
#p l.collect
