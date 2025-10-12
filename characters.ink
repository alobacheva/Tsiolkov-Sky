// Специализации персонажей:
// - Технический анализ
// - Навигация и пилотирование
// - Интуиция
// - Переговоры
// - Анализ неструктурированной информации
// - Техника и ремонт
LIST char_specs = tech_analyse, navigation, intuition, negotiation, unstruct, repair

// Доступные игроку персонажи.
LIST player_chars = Alex, Igor, Vadim, Ekaterina, Maria, Olga

// Персонаж из player_chars выбранный в функции select_current_char_*
VAR current_char = ()

// Буфер персонажей для построения селекторов в функциях *_dynamic
VAR _char_buffer = ()

// Имя и фамилия персонажа.
=== function char_name(id) ===
{ id:
- Alex: Алексей Криптов
- Igor: Игорь Селин
- Vadim: Вадим Рейснер
- Ekaterina: Екатерина Домова
- Maria: Мария Лазарева
- Olga: Ольга Вереск
}

// Сцена выбора персонажей.
// Доступные варианты вычисляются динамически.
=== select_characters_dynamic(->redirect) ===
->select_variant(redirect)
= select_variant(->redirect)
~ _char_buffer = LIST_ALL(player_chars) - player_chars
{ LIST_COUNT(player_chars):
- 0: Кто был первым?
- 1: Кто был следующим?
- 2: Кто был последний?
- 3: ->redirect
}
->next_variant(redirect)
= next_variant(->redirect)
~ temp char_variant = LIST_MAX(_char_buffer)
~ _char_buffer -= char_variant
{ _char_buffer:
    <-next_variant(redirect)
}
+ [{char_name(char_variant)}]
    ~ player_chars += char_variant
- ->select_variant(redirect)


// Сцена выбора персонажа из имеющихся у игрока.
// Выбранный персонаж сохраняется в глобальной переменной current_char.
// Доступные варианты вычисляются динамически.
=== select_current_char_dynamic(->redirect) ===
~ _char_buffer = player_chars
->next_variant(redirect)
= next_variant(->redirect)
~ temp char_variant = LIST_MAX(_char_buffer)
~ _char_buffer -= char_variant
{ _char_buffer:
    <-next_variant(redirect)
}
+ [{char_name(char_variant)}]
    ~ current_char = char_variant
- ->redirect


// Сцена выбора персонажей.
// Доступные варианты перечисляются статически.
=== select_characters_static(selected_char, ->redirect) ===
{ selected_char != ():
    ~ player_chars += selected_char
}
{ LIST_COUNT(player_chars):
- 0: Кто был первым?
- 1: Кто был следующим?
- 2: Кто был последний?
- 3: ->redirect
}
* [{char_name(Alex)}] -> select_characters_static(Alex, redirect)
* [{char_name(Igor)}] -> select_characters_static(Igor, redirect)
* [{char_name(Vadim)}] -> select_characters_static(Vadim, redirect)
* [{char_name(Ekaterina)}] -> select_characters_static(Ekaterina, redirect)
* [{char_name(Maria)}] -> select_characters_static(Maria, redirect)
* [{char_name(Olga)}] -> select_characters_static(Olga, redirect)


// Сцена выбора персонажа из имеющихся у игрока.
// Выбранный персонаж сохраняется в глобальной переменной current_char.
// Доступные варианты перечисляются статически.
=== select_current_char_static ===
+ {player_chars ? Alex} [{char_name(Alex)}]
    ~ current_char = Alex
+ {player_chars ? Igor} [{char_name(Igor)}]
    ~ current_char = Igor
+ {player_chars ? Vadim} [{char_name(Vadim)}]
    ~ current_char = Vadim
+ {player_chars ? Ekaterina} [{char_name(Ekaterina)}]
    ~ current_char = Ekaterina
+ {player_chars ? Maria} [{char_name(Maria)}]
    ~ current_char = Maria
+ {player_chars ? Olga} [{char_name(Olga)}]
    ~ current_char = Olga
- ->->