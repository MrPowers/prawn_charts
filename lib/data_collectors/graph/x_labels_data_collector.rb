class XLabelsDataCollector
  attr_reader :input_data, :graph_width_pdf, :label_height, :label_width
  def initialize(input_data, graph_width_pdf, label_height, label_width)
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @label_height = label_height
    @label_width = label_width
  end

  def horizontal_offset
    label_width / 2
  end

  def collect
    input_data.map.with_index do |(label, _), index|
      x_pdf = x_pdf_data[index] - horizontal_offset
      y_pdf = -(label_height)
      [label, [x_pdf, y_pdf] ]
    end
  end

  private

  def x_pdf_data
    XPdfDataCollector.new(input_data, graph_width_pdf).collect
  end
end
