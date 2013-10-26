[![Code Climate](https://codeclimate.com/github/MrPowers/prawn_charts.png)](https://codeclimate.com/github/MrPowers/prawn_charts)

# Prawn Charts

Prawn Charts is a Prawn graphing library to create linear or log line
charts in Prawn with no dependencies other than Prawn.

## Examples

Clone the respository and run the following script to generate a PDF
file with a log graph on your Desktop:
```bash
$ ruby lib/prawn_charts/examples/log_example.rb
```

This script will generate a PDF file of a log graph that is only 6KB.

![alt tag](https://raw.github.com/MrPowers/prawn_charts/master/images/prawn_charts_log_example.png)


Prawn Charts can also be used to generate linear graphs.  This graph
does not leverage some built in features (i.e. graph title, y label, x label)
and demonstrates that Prawn Charts is easily customizable.

![alt tag](https://raw.github.com/MrPowers/prawn_charts/master/images/simple_linear_example.png)

## Contributing

Please send pull requests - they will be merged :)

## Code Organization

The DataCollectors (located in lib/data_collectors) are responsible for
converting input data to pdf_points, so it can be graphed.  

The RenderingAssistant is responsible for parsing the input hash and
combining user specified data with smart defaults.  The graph is fully
customizable, but smart defaults allow for rapid prototyping.

The PrawnChartRenderer module should be mixed in to Prawn::Document, so the
draw_graph method can be called directly on the Prawn::Document object.
See the lib/prawn_charts/examples/ directory for examples on how to use
this gem.

## Example Input

The entire log example is included in this README for easy reference:

```ruby
Prawn::Document.extensions << PrawnCharts::PrawnChartRenderer
pdf = Prawn::Document.new

data = [
  {x_label: "Apr-11", y: 1_000},
  {x_label: "May-11", y: nil},
  {x_label: "Jun-11", y: nil},
  {x_label: "Jul-11", y: nil},
  {x_label: "Aug-11", y: 300_000},
  {x_label: "Sep-11", y: nil},
  {x_label: "Oct-11", y: nil},
  {x_label: "Dec-11", y: 17},
  {x_label: "Jan-12", y: nil},
  {x_label: "Feb-12", y: nil},
  {x_label: "Mar-12", y: 10},
  {x_label: "Apr-12", y: nil},
  {x_label: "May-12", y: nil},
  {x_label: "Jun-12", y: 1_000_000}
]

orange = "D95D2E"
green = "62C545"
white = "FFFFFF"

colors = {
  :rectangle_fill => white,
  :line => green,
  :dots => orange
}

input = {
  :graph => {
    :starting_point => [100, 400],
    :width => 300,
    :height => 200,
    :data => data,
    :y_labels => ["1", "10", "100", "1,000", "10,000", "100,000", "1,000,000"],
    :scale => :log
  },
  :dots => {},
  :y_labels => {
    :offset => -62,
    :text_box_options => {:width => 55, :align => :right}
  },
  :x_labels => {},
  :horizontal_lines => true,
  :graph_title => { :title => "cool graph" },
  :x_title => { :title => "x title" },
  :y_title => { :title => "y title", :offset => -60 },
}

pdf.draw_graph(input, colors)

pdf.render_file(Dir.home + "/desktop/log_prawn_graph.pdf")
```

The following code illustrates most of the inputs that can be set to
configure the graph:

```ruby
data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}, {y: 14, x_label: "Mar 11"}]
input = {
  :graph => {:starting_point => [100, 200], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]},
  :dots => { :radius => 4 },
  :horizontal_lines => true,
  :graph_title => { :title => "cool graph", :offset => 50, :text_box_options => {} },
  :x_title => { :title => "x title", :offset => -60, :text_box_options => {} },
  :y_title => { :title => "y title", :offset => -50, :text_box_options => {} },
  :x_labels => { :offset => -50, :text_box_options => { :width => 100, :height => 20, align: :center, rotate: 45 } },
  :y_labels => { :offset => -40, :text_box_options => { :height => 40, valign: :center } }
}
```
