class LinearYPdfDataCollector
  attr_reader :input_data, :graph_height_pdf, :y_labels
  def initialize(input_data, graph_height_pdf, y_labels)
    @input_data = input_data
    @graph_height_pdf = graph_height_pdf
    @y_labels = y_labels
  end

  def collect
    input_data.inject([]) do |memo, (_, y_units)|
      result = y_units.nil? ? nil : y_units * pdf_points_per_unit
      memo << result
    end
  end

  private

  def pdf_points_per_unit
    graph_height_pdf.to_f / y_labels.max
  end
end
