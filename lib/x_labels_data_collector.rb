class XLabelsDataCollector
  attr_reader :input_data, :graph_width_pdf, :vertical_offset, :label_width
  def initialize(input_data, graph_width_pdf, vertical_offset, label_width)
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @vertical_offset = vertical_offset
    @label_width = label_width
  end

  def horizontal_offset
    label_width / 2
  end

  def collect
    input_data.map.with_index { |(x, _), index| [x, [x_pdf_data[index] - horizontal_offset, -(vertical_offset)]] }
  end

  private

  def x_pdf_data
    XPdfDataCollector.new(input_data, graph_width_pdf).collect
  end
end
