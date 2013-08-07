require "spec_helper"

module PrawnCharts
  describe ContainerDataCollector do
    before do
      container_inputs = {
        container_left_padding: 7,
        y_label_offset: 50,
        y_label_width: 25,
        y_title_width: 30,
        container_right_padding: 20,
        container_top_padding: 9,
        graph_title_height: 25,
        container_bottom_padding: 40,
        x_label_height: 22,
        x_title_height: 43,
        graph_height: 400,
        graph_width: 500
      }
      @container_data_collector = ContainerDataCollector.new(container_inputs)
    end

    context "#height" do
      it "returns the pdf_height of the graph container" do
        expect(@container_data_collector.height).to eq(539)
      end
    end

    context "#width" do
      it "returns the pdf_width of the graph container" do
        expect(@container_data_collector.width).to eq(632)
      end
    end

    context "#graph_top_left_corner" do
      it "returns the point for the top-left corner of the graph" do
        expect(@container_data_collector.graph_top_left).to eq([112, 505])
      end
    end

    context "#graph_title_top_left" do
      it "returns x, y coordinate for placement of graph title" do
        expect(@container_data_collector.graph_title_top_left).to eq([112, 530])
      end
    end

    context "#y_title_top_left" do
      it "returns x, y coordinate for placement of y title" do
        expect(@container_data_collector.y_title_top_left).to eq([7, 505])
      end
    end

    context "#x_title_top_left" do
      it "returns x, y coordinate for placement of x title" do
        expect(@container_data_collector.x_title_top_left).to eq([112, 83])
      end
    end
  end
end
