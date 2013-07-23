module PrawnCharts
  class Main
    attr_reader :scale, :input_data, :graph_height, :graph_width, :bounding_x, :bounding_y
    def initialize(scale, input_data, graph_height, graph_width, bounding_x, bounding_y)
      @scale = scale
      @input_data = input_data
      @graph_height = graph_height
      @graph_width = graph_width
      @bounding_x = bounding_x
      @bounding_y = bounding_y
    end

    def pdf_data
      PdfData.new(scale, input_data, graph_height, graph_width)
    end

    def draw_line(pdf)
      pdf_data = self.pdf_data.collect
      pdf_data.each_index do |i|
        pdf.stroke_line(pdf_data[i], pdf_data[i + 1]) unless pdf_data[i + 1].nil?
      end
    end

    def draw_dots(pdf)
      pdf_data.collect.each do |x, y|
        pdf.fill_circle([x, y], 4)
      end
    end

    def draw_x_labels(pdf, offset)
      XPdfData.new(input_data, graph_width).x_label_data(offset).each do |label, xy|
        pdf.draw_text(label, at: xy)
      end
    end

    def draw_y_labels(pdf, num_labels, offset)
      LinearYPdfData.new(input_data, graph_height).y_label_data(num_labels, offset).each do |label, xy|
        pdf.draw_text(label, at: xy)
      end
    end

    def draw_graph
      pdf = ::Prawn::Document.new
      pdf.bounding_box([bounding_x, bounding_y], :width => graph_width, :height => graph_height) do
        pdf.stroke_bounds
        draw_line(pdf)
        draw_dots(pdf)
        draw_x_labels(pdf, -20)
        draw_y_labels(pdf, 5, -20)
      end
      pdf.render_file(Dir.home + "/desktop/prawn_graph.pdf")
    end
  end
end
