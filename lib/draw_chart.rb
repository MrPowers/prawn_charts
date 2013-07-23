class DrawChart
  attr_reader :pdf_data, :dot_radius
  def initialize(pdf_data, dot_radius)
    @pdf_data = pdf_data
    @dot_radius = dot_radius
  end

  def draw_line(pdf)
    pdf_data.each_index do |i|
      pdf.stroke_line(pdf_data[i], pdf_data[i + 1]) unless pdf_data[i + 1].nil?
    end
  end

  def draw_dots(pdf)
    pdf_data.each do |point|
      pdf.fill_circle(point, dot_radius)
    end
  end

  def draw_line_and_dots(pdf)
    draw_line(pdf)
    draw_dots(pdf)
  end
end
