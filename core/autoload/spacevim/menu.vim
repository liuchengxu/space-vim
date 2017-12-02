let g:quickmenu_options = 'LH'

function! spacevim#menu#init()
  call quickmenu#current(0)
  call quickmenu#reset()

  " section 1, text starting with "#" represents a section (see the screen capture below)
  call g:quickmenu#append('# Develop', '')

  call g:quickmenu#append('item 1.1', 'echo "1.1 is selected"', 'select item 1.1')
  call g:quickmenu#append('item 1.2', 'echo "1.2 is selected"', 'select item 1.2')
  call g:quickmenu#append('item 1.3', 'echo "1.3 is selected"', 'select item 1.3')

  " section 2
  call g:quickmenu#append('# Misc', '')

  call g:quickmenu#append('item 2.1', 'echo "2.1 is selected"', 'select item 2.1')
  call g:quickmenu#append('item 2.2', 'echo "2.2 is selected"', 'select item 2.2')
  call g:quickmenu#append('item 2.3', 'echo "2.3 is selected"', 'select item 2.3')
  call g:quickmenu#append('item 2.4', 'echo "2.4 is selected"', 'select item 2.4')

  " window
  call quickmenu#append('split window horizontally', 'split', 'split window')

  " toggle
  call quickmenu#append('# Toggle', '')
  call quickmenu#append('Function List', 'TagbarToggle', 'Switch Tagbar on/off')
  call quickmenu#append('Function List', 'GitGutterToggle', 'Switch Tagbar on/off')
  call quickmenu#append("Turn paste %{&paste? 'off':'on'}", "set paste!", "enable/disable paste mode (:set paste!)")
  call quickmenu#append("Turn spell %{&spell? 'off':'on'}", "set spell!", "enable/disable spell check (:set spell!)")
  call quickmenu#append("Cursor column %{&cursorcolumn ? 'off' : 'on'}", 'call spacevim#util#ToggleCursorColumn()', 'Switch Tagbar on/off')

  " cscope
  call quickmenu#append('# Cscope', '')
  call quickmenu#append('this C symbol', 'Call', 'Find this C symbol')
  call quickmenu#append('this definition', 'call', 'Find this definition')
  call quickmenu#append('functions called by this function', 'call', 'Find functions called by this function')
  call quickmenu#append('functions calling this function', 'call', 'Find functions calling this function')
  call quickmenu#append('this text string', 'call', 'Find this text string')
  call quickmenu#append('this egrep pattern', 'call', 'Find this egrep pattern')
  call quickmenu#append('this file', 'call', 'Find this file')
  call quickmenu#append('files #including this file', 'call', 'Find files #including this file')
  call quickmenu#append('places where this symbol is assigned a value', 'call', 'Find places where this symbol is assigned a value')


  call quickmenu#toggle(0)
endfunction
