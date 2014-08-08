module ResearchesHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to '#', class: "add_fields btn btn-success", data: {id: id, fields: fields.gsub("\n", ""),dimenions: ""} do
    	"<span class='glyphicon glyphicon-plus'></span>#{name}".html_safe
    end
  end
end
