class LabelRenderer
  def initialize(label_data, options)
    @label_data = label_data
    @options = options
  end

  def draw(pdf)
    @label_data.each do |label, pdf_point|
      pdf.text_box(label, { at: pdf_point }.merge(@options))
    end
  end
end
