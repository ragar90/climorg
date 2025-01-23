# encoding: utf-8
module ApplicationHelper
	def error_messages!(resource)
	    return "" if resource.errors.messages.empty?

	    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
	    errors_count = resource.errors.count
	    resource.class.reflect_on_all_associations(:has_many).map(&:name).each do |assoc|
				puts "#{resource.class.to_s} #{assoc}"
				unless assoc.to_sym == :reports
					resource.send(assoc).each do |nested_object|
						messages += nested_object.errors.full_messages.map { |msg| content_tag(:li, "#{msg}: #{nested_object.to_s}") }.join
						errors_count += nested_object.errors.count
					end
				end
	    end
	    sentence = I18n.t("errors.messages.not_saved",
	                      :count => errors_count,
	                      :resource => resource.class.model_name.human.downcase)

	    html = <<-HTML
			<div class= "alert alert-error fade in">
			<a class="close" data-dismiss="alert" href="#">×</a>
			<h2>#{sentence}</h2>
			<ul>#{messages}</ul>
			</div>
		HTML
    html.html_safe
  end

  def error_messages_for_demographic_values(resources)
    messages = ""
    errors_count = 0
    resources.each do |resource|
      next if resource.errors.messages.empty?
      errors_count += resource.errors.count
      errors = content_tag(:ul,resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join)
      messages += content_tag(:li, "Errors for #{resource.demographic_variable.name} #{errors}")
    end
    return "" if errors_count == 0
    html = <<-HTML
			<div class= "alert alert-error fade in">
			<a class="close" data-dismiss="alert" href="#">×</a>
			<h2>Ocurrieron #{errors_count} errores</h2>
			<ul>#{messages}</ul>
			</div>
		HTML
    html.html_safe
  end
end
