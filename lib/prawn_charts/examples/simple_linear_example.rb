require_relative "./../../prawn_charts"

module PrawnCharts
  class CreateLinearExample
    def input_data
      [["Apr-11", 10],
      ["May-11", 30],
      ["Jun-11", 50],
      ["Jul-11", 3],
      ["Aug-11", 40],
      ["Sep-11", nil],
      ["Oct-11", nil],
      ["Dec-11", 100],
      ["Jan-12", nil],
      ["Feb-12", nil],
      ["Mar-12", 5],
      ["Apr-12", nil],
      ["May-12", nil],
      ["Jun-12", 75]]
    end

    def scale
      :linear
    end

    def graph_height_pdf
      200
    end

    def graph_width_pdf
      graph_height_pdf * 1.7
    end

    def dot_radius
      4
    end

    def x_label_width
      50
    end

    def x_label_height
      35
    end

    def x_label_text_box_options
      { overflow: :shrink_to_fit, align: :center, rotate: 45 }
    end

    def y_labels
      [0, 25, 50, 75, 100, 125]
    end

    def y_label_height
      30
    end

    def y_label_width
      65
    end

    def y_label_offset
      10
    end

    def y_label_text_box_options
      { align: :right, valign: :center }
    end

    def pdf_data
      PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
    end

    def x_label_data
      XLabelsDataCollector.new(input_data, graph_width_pdf, x_label_height, x_label_width).collect
    end

    def y_label_data
      YLabelsDataCollector.new(y_labels, graph_height_pdf, y_label_width, y_label_height, y_label_offset).collect
    end

    def horizontal_lines_data
      HorizontalLinesDataCollector.new(graph_height_pdf, graph_width_pdf, y_labels).collect
    end
  end

end

Prawn::Document.extensions << PrawnCharts::PrawnChartRenderer

pdf = Prawn::Document.new

le = PrawnCharts::CreateLinearExample.new

pdf.bounding_box([50, pdf.cursor], :width => le.graph_width_pdf, :height => le.graph_height_pdf) do
  pdf.stroke_bounds
  pdf.draw_chart(le.pdf_data)
  pdf.draw_dots(le.pdf_data, le.dot_radius)
  pdf.draw_labels(le.x_label_data, le.x_label_width, le.x_label_height, le.x_label_text_box_options)
  pdf.draw_labels(le.y_label_data, le.y_label_width, le.y_label_height, le.y_label_text_box_options)
  pdf.draw_horizontal_lines(le.horizontal_lines_data)
end

pdf.render_file(Dir.home + "/desktop/simple_linear_prawn_graph.pdf")
