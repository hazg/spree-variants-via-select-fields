class OptionHandler

  variant_selects_products: []

  constructor:(variant_selects_products) ->
    @variant_selects_products = variant_selects_products
    $('.option-type-select').bind 'mouseover', (e) => @onExpand(e)
    $('.option-type-select').bind 'mouseout', (e) =>
      $(e.currentTarget).find('.option_values').trigger('change')
      $('[undisabled=undisabled]').removeAttr('undisabled').attr('disabled', 'disabled')



  onExpand: (e) =>
    $this = $(e.currentTarget).find('select')
    $this.find('option[disabled=disabled]').removeAttr('disabled').attr('undisabled', 'undisabled')
    styled_items = @getStyledItems($this)
    styled_items.removeAttr('disabled').attr('undisabled', 'undisabled')
    

  valid: ->
    @variant_selects_products.length > 0

  
  
  setToFirstVariant: ->
    $('.option_values').each (index, element) =>
      $(element).val(@variant_selects_products[0][index + 1])

    this.enableDisableOptions $('.option_values').first(), @variant_selects_products[0][1]

  
  
  getStyledItems: (current_select) ->
    styled_items = new Array
    if $.fn.easyDropDown? and current_select.parent().is('span.old')
        styled_items =current_select.parents('.dropdown').find('> div:last-child > ul > li')
        current_select.parents('.dropdown').animate('border:1px solid red').animate('border:3px solid blue')
    styled_items

  
  enableDisableOptions: (select, option) ->
    position = undefined
    $('.option_values').each (index) ->
      if select.attr('name') == $(this).attr('name')
        position = index + 1
    
    
      
    $('.option_values').each (index, element) =>
      current_select = $(element)
      
      styled_items = @getStyledItems(current_select)
      # spree_fancy: EasyDropDown
      
      if select.attr('name') != current_select.attr('name')
        current_select.children().each (i, element) =>
          $(styled_items[i]).attr('disabled', 'disabled') if styled_items?
          $(element).attr('disabled', 'disabled').css('border', '1px solid blue')
          for variant in @variant_selects_products
            if (variant[index + 1].toString() == $(element).val() && variant[position].toString() == option.toString())
              $(element).removeAttr('disabled')
              $(styled_items[i]).removeAttr('disabled') if styled_items?


      if ($("#" + current_select.attr('id') + " option:selected").attr('disabled') == 'disabled')
        current_select.children().each ->
          if $(this).attr('disabled') == undefined
            current_select.val $(this).val()
      

    # finding the actual variant ID and setting the hidden field for the order process
    current_variant = new Array
    $('#product_id').attr('value', undefined)
    $('.option_values').each (index) ->
      current_variant[index] = $(this).val()


    for variant in @variant_selects_products
      if variant[1..variant.length].toString() == current_variant.toString()
        $('#product_id').attr('value', variant[0])


    if $('#product_id').attr('value') == undefined
      $('#product_id').html("The selected product is not available!")

Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

jQuery ->
  if variants?
    window.option_handler = new OptionHandler(variants)

    #if !option_handler.valid
    #  console.log "OptionHandler not initialised"

    option_handler.setToFirstVariant()

    option_val = undefined
    
    # BAD BAD BAD
    #  $('.option_values').each (i, v)->
    #  $this = $(this)
    #  possible = []
    #  for variant in variants
    #  possible.push(variant[i+1])
    #  $(v).attr('possible-values', possible.unique().join(' '))
    #  for legal in possible
    #  $this.find("[value=#{legal}]").addClass('legal')
    #  $this.find('option:not(.legal)').remove()
    # END OF BAD
    
    $('.option_values').change ->
      option_val = $("#" + $(this).attr('id') + " option:selected").val()
      option_handler.enableDisableOptions $(this), option_val

      $('li.active[disabled=disabled]').each ->
        if dropdown = $(this).parents('.dropdown').find('select')
          dropdown.easyDropDown('destroy').easyDropDown()
