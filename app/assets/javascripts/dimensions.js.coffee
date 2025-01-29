jQuery ->
  $('.dimension_form').on 'click', '.add_fields', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      html = $(this).data('fields').replace(regexp, time)
      $(".dimension-variables-fields").append(html)
      dimension_id = $(".questions-tab .tab-pane.active").attr("id").split("_")[0]
      $("#research_questions_attributes_#{time}_dimension_id").val(dimension_id)
      load_dimension_values($(".dq_select").last())
      event.preventDefault()
  $('.dimension_form').on 'click', '.remove_fields', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('.dimension-variable-fields').hide()
      event.preventDefault()