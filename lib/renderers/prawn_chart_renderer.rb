module PrawnChartRenderer
  def draw_chart(pdf_data, color = "000000")
    self.stroke_color = color
    pdf_data.each_index do |i|
      stroke_line(pdf_data[i], pdf_data[i + 1]) unless pdf_data[i + 1].nil?
    end
  end

  def draw_dots(pdf_data, dot_radius, color = "000000")
    self.fill_color = color
    pdf_data.each do |point|
      fill_circle(point, dot_radius)
    end
  end

  def draw_horizontal_lines(horizontal_lines_data, color = "000000")
    self.stroke_color = color
    horizontal_lines_data.each do |start_x, end_x, y|
      stroke_horizontal_line start_x, end_x, at: y
    end
  end

  def draw_labels(label_data, width, height, options = {}, color = "000000")
    self.fill_color = color
    label_data.each do |label, pdf_point|
      text_box(label, { at: pdf_point, width: width, height: height }.merge(options))
    end
  end
end
