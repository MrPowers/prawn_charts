class LinearYPdfDataCollector
  attr_reader :input_data, :graph_height_pdf
  def initialize(input_data, graph_height_pdf)
    @input_data = input_data
    @graph_height_pdf = graph_height_pdf
  end

  def max_y_units
    input_data.map { |_, y_units| y_units }.max
  end

  def y_label_increment_pdf
    @graph_height_pdf.to_f / max_y_units
  end

  def collect
    input_data.inject([]) { |memo, (_, y_units)| memo << y_units * y_label_increment_pdf; memo }
  end
end
