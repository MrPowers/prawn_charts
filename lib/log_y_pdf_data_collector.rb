class LogYPdfDataCollector
  attr_reader :input_data, :graph_height_pdf, :y_labels
  def initialize(input_data, graph_height_pdf, y_labels)
    @input_data = input_data
    @graph_height_pdf = graph_height_pdf
    @y_labels = y_labels
  end

  def pdf_points_per_unit
    graph_height_pdf.to_f / (y_labels.count - 1)
  end

  def collect
    input_data.inject([]) { |memo, (_, y_units)| memo << (Math.log10(y_units) * pdf_points_per_unit); memo }
  end
end

#input_data = [["Jan 11", 5], ["Feb 11", 900], ["Mar 11", 800_000]]
#graph_height_pdf = 60
#y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000]
#y = LogYDataCollector.new(input_data, graph_height_pdf, y_labels)
#p y.y_label_increment_pdf
#p y.collect
