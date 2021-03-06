# Обработка блока причин на главной
$ ->
  reasons.init()

  # При нажатии по кнопке рассказать у причины открывает окно рассказать с текстом причины
  $(document).on "click", ".reason", ->
    reasons.copy_reason($(this))

  $(document).on "mouseenter", ".reason, .news_article", ->
    $(this).addClass("hovered")
  $(document).on "mouseleave", ".reason, .news_article", ->
    $(this).removeClass("hovered")

# Параметры и функции, связанные с блоком причин
reasons =
  # Отображение трех причин на главной
  init: ->
    @.get_three()

    # Каждые 10 сек подгружает новые причины на десктопах
    setInterval (->
      unless app.mobile
        reasons.get_three()
    ), 10000


  # Грузит три случайные причины в блок причин
  get_three: ->
    unless $("body").hasClass("loading_three")
      $.ajax
        type: 'GET'
        url: "../reasons/get_three_random"
        dataType: 'script'
        beforeSend: ->
          $("body").addClass("loading_three")
          $("#more_reasons").toggleClass("loading")
          $("#more_reasons img").toggleClass("hidden")
        success: ->
          $("body").removeClass("loading_three")
          $("#more_reasons").toggleClass("loading")
          $("#more_reasons img").toggleClass("hidden")


  # Берет текст причины и вставляет его в поле рассказать у модульного окошка
  # @param share_reason_button [DOM element] кнопка рассказать у причины
  copy_reason: ($reason_block) ->
    text = $.trim($reason_block.find(".text").text())
    $("#share_modal").modal()
    $("#reason_field").val(text).trigger("change")