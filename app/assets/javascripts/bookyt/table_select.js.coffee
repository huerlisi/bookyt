class Bookyt.Table
  constructor: () ->
    @table = $('form[data-table-select]')
    return unless @table.length > 0

    $(document).keydown @keyHandler

    $(document).on 'click click.rails', '[data-table-key=13]', () ->
      $(this).trigger('submit.rails') if @state == 'edit'

    @enterNavigate()
    @selectFirstRow()

  enterEdit: () =>
    @state = 'edit'
    @unselectRow()

  enterNavigate: () =>
    @state = 'navigate'

  navigationKeyHandler: (e) =>
    switch e.which
      when 40 # Arrow Down
        @selectNextRow()
      when 38 # Arrow Up
        @selectPreviousRow()
      when 13 # ENTER
        @currentRow().find('[data-table-key=13]').trigger('click.rails')
        @enterEdit()
      when 69 # 'e'
        @currentRow().find('[data-table-key=69]')[0].click()
      when 68 # 'd'
        # TODO: possible race
        @currentRow().find('[data-table-key=68]').trigger('click.rails')
        @selectNextRow()
      when 67 # 'c'
        @currentRow().find('[data-table-key=67]')[0].click()
      else
        return

    e.preventDefault()

  editKeyHandler: (e) =>
    switch e.which
      when 27 # ESC
        @table.find('[data-table-key=27]').trigger('click.rails')
        @enterNavigate()

      when 13 # ENTER
        @table.trigger('submit.rails')
        @enterNavigate()
      else
        return

    e.preventDefault()

  keyHandler: (e) =>
    switch @state
      when 'navigate'
        @navigationKeyHandler(e)
      when 'edit'
        @editKeyHandler(e)

  currentRow: ->
    $('tr.selected')

  startTableSelection: ->
    $(':focus').blur()
    @enterNavigate()

  unselectRow: (row) ->
    @currentRow().removeClass('selected')
    @currentRow().popover('hide')

  selectRow: (row) ->
    @unselectRow()

    $(row).addClass('selected')

    $(row).popover('show') if $(row).data('content')
    $(row).scrollintoview()
    $(row).mouseenter()

  selectFirstRow: ->
    @selectRow(@table.find('tr').eq(1))

  selectLastRow: ->
    @selectRow(@table.find('tr').last())

  selectNextRow: ->
    new_row = @currentRow().next 'tr'
    @selectRow new_row if new_row.length > 0

  selectPreviousRow: ->
    new_row = @currentRow().prev 'tr'
    @selectRow new_row if new_row.length > 0

$ =>
  @bookyt_table = new Bookyt.Table
