class DrawLabels
  def initialize(x_label_data, label_width)
    @x_label_data = x_label_data
    @label_width = label_width
  end

  def draw_x_labels(pdf)
    @x_label_data.each do |label, pdf_point|
      pdf.text_box(label, at: pdf_point, width: @label_width, height: 25, overflow: :shrink_to_fit, align: :center)
    end
  end
end
