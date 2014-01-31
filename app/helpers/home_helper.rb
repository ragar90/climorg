module HomeHelper
  #object, data_method, chart_type, report_type
  def gchart_window(window_options = {}, chart_options = {} )
    window_options[:report_type] = :global if window_options[:report_type].nil?
    window_options[:window_type] = :report if window_options[:window_type].nil?
    window_options[:chart_library] = :gcharts if window_options[:chart_library].nil?
    window_options[:more_reports] = false if window_options[:more_reports].nil?
    locals = { window_id:  SecureRandom.uuid, chart_options: chart_options}
    locals.merge!(window_options)
    render partial: "/shared/data_window", locals: locals
  end

  def gchart(id = SecureRandom.uuid,type,chart_data, is_copy ,html_data)
    div_id = is_copy ? "chart-copy-#{id}" : "chart-#{id}"
    chart_dimensions = is_copy ? {width: 1500, height: 900, id: id} : {height: 300, id: id}
    chart_options = html_data.merge(chart_dimensions)
    data_attributes = {env:chart_data, type: type, chart_options: chart_options }
    content_tag :div, "",id: div_id, data: data_attributes, class: "report-chart #{is_copy ? "chart-copy" : ""} #{ type}" 
  end
end
