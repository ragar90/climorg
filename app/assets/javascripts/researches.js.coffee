# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@display_errors = (errors) ->
  header_msg = "No se pudo guardar este registro debido a uno o mas errores"
  alert_html = "<div class='alert alert-error' style='display:none;><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button><h4 class='errors-header'></h4><ul class='errors-list'></ul></div>"
  $("#modal_errors").html(alert_html)
  msg_list = ""
  $("#modal_errors .errors-header").html(header_msg)
  for error of errors
    msg_list += "<li>" + error + ": " + errors[error][0]+"</li>"
  $("#modal_errors .errors-list").html(msg_list)
  $("#modal_errors .alert").show("slow")

@load_dimension_values = (element) ->
  values = []
  if $(element).length > 1
    $(element).each( (i,e) -> 
      values.push($(e).val()) )
  $(element).html("")
  d = $("#research_dimension_ids option[selected='selected']")
  options =  ""
  i = 0
  while i < d.length
    options = options + "<option value=" + $(d[i]).val() + ">" + $(d[i]).text() + "</option>"
    i++
  $(element).append(options)
  $(element).each( (i,e) -> 
      $(e).val(values[i]) )
  return true

@add_option_to_select = (select, value, display_value) =>
  select_option = "<option value='"+value+"' selected='selected'>"+display_value+"</option>"
  $("#research_"+select+"_ids").append(select_option)
  $("#research_"+select+"_ids").bootstrapDualListbox('refresh', true);

@multiselect_options_text = (options) ->
  if options.length is 0
    "None selected <b class=\"caret\"></b>"
  else if options.length >= 3
    options.length + " selected  <b class=\"caret\"></b>"
  else
    selected = ""
    options.each ->
      selected += $(this).text() + ", "
    selected.substr(0, selected.length - 2) + " <b class=\"caret\"></b>"

@arr_diff = (a1, a2) ->
  a = []
  diff = []
  i = 0
  while i < a1.length
    a[a1[i]] = true
    i++
  i = 0
  while i < a2.length
    if a[a2[i]]
      delete a[a2[i]]
    else
      a[a2[i]] = true
    i++
  for k of a
    diff.push k
  return diff
jQuery ->
  # Data initialization
  $("#dimension_tabs").children().each (index, tab) ->
    id = $(tab).attr("id").split("_")[0] 
    tab_str = $("<div/>").append($(tab).clone()).html()
    panel_str = $("<div/>").append($("##{id}_panel").clone()).html()
    dim_ob = 
      tab_html: tab_str
      panel_html: panel_str
    $("#questions-set").data("#{id}-html",dim_ob)
  selected_dimensions = $("#research_dimension_ids").val()
  $("#questions-set").data("selected_dimensions",selected_dimensions)
  $(".datetime_select").datetimepicker(format: "DD/MM/YYYY", pickTime: false)
  $("#research_dimension_ids").bootstrapDualListbox({
    infoText1: "Dimensiones excluidas", 
    infoText2: "Dimensiones seleccionadas",
    infoTextEmpty1: "No hay dimensiones disponibles",
    infoTextEmpty2: "No hay dimensiones disponibles",
  })
  $("#research_demographic_variable_ids").bootstrapDualListbox({
    infoText1: "Variables demograficas excluidas", 
    infoText2: "Variables demograficas seleccionadas",
    infoTextEmpty1: "No hay variables demograficas disponibles",
    infoTextEmpty2: "No hay variables demograficas disponibles"
  })
  unselected_ids = $("#research_dimension_ids").children("option:not(:selected)").map ->
    $(@).val()
  unselected_ids = jQuery.makeArray(unselected_ids)
  $("#unselected_ids").val(unselected_ids)
  selected_ids = $("#research_dimension_ids").children("option:selected").map ->
    $(@).val()
  selected_ids = jQuery.makeArray(selected_ids)
  $("#selected_ids").val(selected_ids)
  # Event Bindings
  $('.research_form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.question-fields').hide()
    event.preventDefault()
  $('.research_form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    html = $(this).data('fields').replace(regexp, time)
    $(".questions-tab .tab-pane.active").append(html)
    dimension_id = $(".questions-tab .tab-pane.active").attr("id").split("_")[0]
    $("#research_questions_attributes_#{time}_dimension_id").val(dimension_id)
    load_dimension_values($(".dq_select").last())
    event.preventDefault()
  $("#modalView").on "hidden", ->
    $(@).html("")
  $(document).on "change", "#research_dimension_ids", (e) ->
    vals = $(@).val() || []
    unselected_ids = jQuery.makeArray(unselected_ids)
    $("#unselected_ids").val(unselected_ids)
    selected_ids = $("#research_dimension_ids").children("option:selected").map ->
      $(@).val()
    selected_ids = jQuery.makeArray(selected_ids)
    $("#selected_ids").val(selected_ids)
    $("#dimension_tabs").html("")
    $("#dimension_panels").html("")
    $.each vals, (index, value) ->
      dim_ob = $("#questions-set").data("#{value}-html")
      if dim_ob is undefined
        dimension_id = value
        research_id = $("#research_id").val()
        url = "/researches/#{research_id}/dimensions/#{dimension_id}/questions"
        $.get url, (data) ->
          panel_html = "#{data}"
          name = $("#research_dimension_ids").children("option[value='#{value}']").text()
          dim_ob = 
            tab_html: "<li id = '#{value}_tab' ><a href='##{value}_panel' role='tab' data-toggle='tab'>#{name}</a></li>"
            panel_html: panel_html
          $("#questions-set").data("#{value}-html",dim_ob)
          $("#dimension_tabs").append(dim_ob.tab_html)
          $("#dimension_panels").append(dim_ob.panel_html)
          $("#dimension_tabs ##{value}_tab").tab('show')
          $(".tab-pane").removeClass("active")
          id = $("#dimension_tabs ##{value}_tab a").attr("href")
          $(id).addClass("active")
      else
        $("#dimension_tabs").append(dim_ob.tab_html)
        $("#dimension_panels").append(dim_ob.panel_html)
    $("#questions-set").data("selected_dimensions",vals)
  $(document).on "click",".new_setting_link", (e) ->
    remote_url = $(@).attr("href")
    $("#modalView .modal-content").load(remote_url)
    $("#modalView").modal
    $("#modalView").modal("show")
    $("a[data-toggle=tooltip]").tooltip(placement:"right")
    e.preventDefault()
  $(document).on "ajax:success", ".modal_form", (evt, data, status, xhr) -> 
    errors = data["errors"]
    if errors isnt `undefined` or errors?
      display_errors(errors)
    else
      console.log "before setting new options"
      add_option_to_select(data.class, data.value,data.display_value)
      $("#modalView").modal("hide")
  $(document).on "click","#submit_modal_form_btn", (e) ->
    set_display_values()
    $(".modal_form").trigger("submit.rails");
    e.preventDefault()
  $(document).on "click","#cancel_modal_form_btn", (e) ->
    $("#modalView").modal('hide')
    e.preventDefault()
  $(document).on "click", "#upload-btn", (e) ->
    e.preventDefault()
    $("#employees-file-field").click()
  $(document).on "change", "#employees-file-field", (e) ->
    $("#employees-file-form").submit()
  $(document).on "click", ".minimize-btn", (e) ->
    e.preventDefault()
    open = $(@).data("open")
    if open
      $($(@).parent()).siblings(".fieldset-body").slideUp()
      $(@).data("open",!open)
      $(@).children("span").removeClass("fa-minus")
      $(@).children("span").addClass("fa-plus")
    else
      $($(@).parent()).siblings(".fieldset-body").slideDown()
      $(@).data("open",!open)
      $(@).children("span").removeClass("fa-plus")
      $(@).children("span").addClass("fa-minus")


