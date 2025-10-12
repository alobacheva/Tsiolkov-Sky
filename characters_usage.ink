INCLUDE characters.ink

Тестирование выбора персонажей.
//-> select_characters_static((), ->selected_chars)
-> select_characters_dynamic(->selected_chars)

= selected_chars
Ура, персонажи выбраны: {player_chars}

Тест выбора персонажа для сцены:
//->select_current_char_static->selected_current
->select_current_char_dynamic(->selected_current)

= selected_current
Выбран персонаж: {current_char}.

-> END