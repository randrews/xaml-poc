require "wpf.rb"
require "PresentationFramework"
require "PresentationCore"

require "bin/Release/WindowsFormsIntegration.dll"
require "bin/Release/System.Windows.Forms.DataVisualization.dll"
require "bin/Release/System.Drawing.dll"

include System::Windows
include System::Windows::Forms::DataVisualization::Charting

class App < Application
  def initialize
    window = Wpf.load_xaml_file "Window1.xaml"
    window.find_name("helloField").Text = "Click the button"
    window.find_name("sayHello").click do
      window.find_name("helloField").Text = "Hello, World!"
    end

    chart1 = Chart.new
    series1 = Series.new
    chartArea1 = ChartArea.new

    data = [1, 4, 9, 16, 25]
    data.each_with_index{|d,i| series1.Points.AddXY i, d}

    chart1.ChartAreas.Add(chartArea1);
    series1.ChartType = SeriesChartType.line;
    series1.Color = System::Drawing::Color.red
    chart1.Series.Add(series1);

    window.find_name("wfHost").Child = chart1

    window.show    
  end
end

$app = App.new.run
