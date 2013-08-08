require_relative "../../prawn_charts"

module PrawnCharts
  class CreateLogPdf
    ##################################
    #Graph Data Collectors
    ##################################
    def input_data
      [["Apr-11", 5_000_000],
        ["May-11", nil],
        ["Jun-11", nil],
        ["Jul-11", nil],
        ["Aug-11", 1_000_000],
        ["Sep-11", nil],
        ["Oct-11", nil],
        ["Dec-11", 10_000],
        ["Jan-12", nil],
        ["Feb-12", nil],
        ["Mar-12", 150_000],
        ["Apr-12", nil],
        ["May-12", nil],
        ["Jun-12", 7_500_000]]
    end

    def scale
      :log
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
      [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000]
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

    def graph_title_text
      "Cool Prawn Graph"
    end

    def graph_title_height
      40
    end

    def y_title_width
      30
    end

    def y_title_text
      "HCV Viral Load"
    end

    def x_title_height
      40
    end

    def x_title_text
      "Month"
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

    ##################################
    #Container Data Collectors
    ##################################

    def container_inputs
      {
        container_left_padding: 0,
        y_label_offset: y_label_offset,
        y_label_width: y_label_width,
        y_title_width: y_title_width,
        container_right_padding: 20,
        container_top_padding: 20,
        graph_title_height: graph_title_height,
        container_bottom_padding: 0,
        x_label_height: x_label_height,
        x_title_height: x_title_height,
        graph_height: graph_height_pdf,
        graph_width: graph_width_pdf
      }
    end

    def container_data_collector
       ContainerDataCollector.new(container_inputs)
    end

    def graph_title_position
      container_data_collector.graph_title_top_left
    end

    def graph_title_options
      { align: :center, valign: :center}
    end

    def graph_title_data
      GraphTitleDataCollector.new(graph_title_text, graph_title_position, graph_title_height, graph_width_pdf).collect
    end

    def y_title_position
      container_data_collector.y_title_top_left
    end

    def y_title_options
      # specifying width is a temp hack solution because of a Prawn bug: https://github.com/prawnpdf/prawn/pull/505
      { align: :center, valign: :center, rotate: 90, rotate_around: :center, width: 65 }
    end

    def y_title_data
      GraphTitleDataCollector.new(y_title_text, y_title_position, graph_height_pdf, y_title_width).collect
    end

    def x_title_position
      container_data_collector.x_title_top_left
    end

    def x_title_options
      { align: :center, valign: :center }
    end

    def x_title_data
      GraphTitleDataCollector.new(x_title_text, x_title_position, x_title_height, graph_width_pdf).collect
    end

    def graph_top_left
      container_data_collector.graph_top_left
    end
  end
end

##################################
#Colors
##################################

orange = "D95D2E"
green = "62C545"
light_blue = "EDF1F7"
white = "FFFFFF"
black = "000000"

##################################
#Create PDF
##################################

Prawn::Document.extensions << PrawnCharts::PrawnChartRenderer

lg = PrawnCharts::CreateLogPdf.new

pdf = Prawn::Document.new
pdf.bounding_box([0, pdf.cursor], :width => lg.container_data_collector.width, :height => lg.container_data_collector.height) do
  pdf.stroke_bounds
  pdf.fill_color = light_blue
  pdf.fill_rectangle([0, pdf.cursor], lg.container_data_collector.width, lg.container_data_collector.height)
  pdf.fill_color = black

  pdf.draw_title(lg.graph_title_data, lg.graph_title_options)
  pdf.draw_title(lg.y_title_data, lg.y_title_options)
  pdf.draw_title(lg.x_title_data, lg.x_title_options)

  pdf.bounding_box(lg.container_data_collector.graph_top_left, :width => lg.graph_width_pdf, :height => lg.graph_height_pdf) do
    pdf.stroke_bounds
    pdf.fill_color = white
    pdf.fill_rectangle([0, pdf.cursor], lg.graph_width_pdf, lg.graph_height_pdf)

    pdf.stroke_color = green
    pdf.draw_chart(lg.pdf_data)
    pdf.fill_color = orange
    pdf.draw_dots(lg.pdf_data, lg.dot_radius)

    pdf.fill_color = black
    pdf.draw_labels(lg.x_label_data, lg.x_label_width, lg.x_label_height, lg.x_label_text_box_options)

    pdf.draw_labels(lg.y_label_data, lg.y_label_width, lg.y_label_height, lg.y_label_text_box_options)

    pdf.stroke_color = black
    pdf.draw_horizontal_lines(lg.horizontal_lines_data)
  end
end
pdf.render_file(Dir.home + "/desktop/log_prawn_graph.pdf")
