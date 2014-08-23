module DataTableHelper
	def datatable(collection, column_names, options, &block)
		render partial: "/shared/datatable_load"
		options[:searching] = false if options[:searching].nil?
		options[:serverSide] = false if options[:serverSide].nil?
		options[:lengthChange] = false if options[:lengthChange].nil?
		DataTable.new(self,collection,column_names,options,block).table.html_safe
	end

	class DataTable < Struct.new(:view, :collection,:column_names,:options,:callback)
		delegate :content_tag, to: :view
		def table
			content_tag :table, id: "collection_list", class: "display table table-striped", data:{options:options} do
				table_head + table_body
			end
		end

		def table_head
			model_class = collection.klass
			content_tag :thead do
				content_tag :tr do
					headers = column_names.map do |column|
						content_tag :th do
							model_class.human_attribute_name(column.to_sym) rescue ""
						end
					end
					headers.join.html_safe
				end
			end
		end

		def table_body
			content_tag :tbody do
				table_rows = collection.map do |record|
					content_tag :tr, view.capture(record, column_names, &callback)
				end
				table_rows.join.html_safe
			end
		end

	end
end