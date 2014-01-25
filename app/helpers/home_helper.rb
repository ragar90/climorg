module HomeHelper
  def gchart_window(object, window_type, data_method, chart_type, chart_options = {} )
    locals = { window_id:  SecureRandom.uuid, object: object, window_type: window_type, data_method: data_method, chart_type: chart_type, chart_options: chart_options }
    render partial: "/shared/data_window", locals: locals
  end

  def gchart(id = SecureRandom.uuid,type,chart_data, is_copy ,html_data)
    div_id = is_copy ? "chart-copy-#{id}" : "chart-#{id}"
    chart_dimensions = is_copy ? {width: 1500, height: 900} : {height: 300}
    chart_options = html_data.merge(chart_dimensions)
    data_attributes = {env:chart_data, type: type, chart_options: chart_options }
    content_tag :div, "",id: div_id, data: data_attributes, class: "report-chart #{is_copy ? "chart-copy" : ""}" 
  end
end
