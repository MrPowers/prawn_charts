class HorizontalLinesRenderer
  attr_reader :horizontal_lines_data
  def initialize(horizontal_lines_data)
    @horizontal_lines_data = horizontal_lines_data
  end

  def draw(pdf)
    horizontal_lines_data.each do |start_x, end_x, y|
      pdf.stroke_horizontal_line start_x, end_x, at: y
    end
  end
end
