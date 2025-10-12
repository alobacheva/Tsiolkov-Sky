// https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md

// Бросок кубов. Возвращет лучшее d6 значение.
//
// speed / bonus_speed - выбранная и бонусная скорости (0 - медленно, 1 - быстро).
// spec / bonus_spec - специализация персонажа и бонусная специализация.
// bonus_dices - бонусные кубы, включая штраф (отрицательное значение).
// laser - бросок на лазеры или чувства (true/false).
=== function start_rolling(speed, bonus_speed, spec, bonus_spec, bonus_dices, laser) ===
~ temp rolls = 1 + bonus_dices
{ speed == bonus_speed:
    ~ rolls = rolls + 1
}
{ spec == bonus_spec:
    ~ rolls = rolls + 1
}
{ rolls < 1:
    ~ rolls = 1
}
Бросок {rolls} кубов ...
~ return keep_rolling(laser, rolls, 999)

=== function keep_rolling(laser, rolls, best) ===
{ rolls > 0:
    ~ temp dice = RANDOM(1, 6)
    <> {dice}
    {
    - best == 999:
        ~ best = dice
    - laser == true && dice < best:
        ~ best = dice
        <> (лучше предыдущего)
    - laser == false && dice > best:
        ~ best = dice
        <> (лучше предыдущего)
    }
    ~ return keep_rolling(laser, rolls - 1, best)
- else:
    ~ return best
}

// Итерация оппозитных бросков. Возвращает булевое значение или повторно вызывает себя же.
//
// o_char, p_char - характиристики оппонента и игрока.
// speed / bonus_speed - выбранная и бонусная скорости (0 - медленно, 1 - быстро).
// p_spec, o_spec, b_spec - специализации игрока, оппонента и бонусная.
// bonus_dices - бонусные или штрафные кубы игрока.
// laser - бросок на лазеры или чувства (true/false).
=== function start_opposite_rolling(o_char, p_char, speed, bonus_speed, p_spec, o_spec, b_spec, bonus_dices, laser) ===
Оппозитные броски.

Оппонент: <>
~ temp opponent_dice = start_rolling(1, bonus_speed, o_spec, b_spec, 0, laser)
~ temp opponent_result = opponent_dice - o_char
Результат: {opponent_dice} (выпало) - {o_char} (характеристика) = {opponent_result}.

Игрок: <>
~ temp player_dice = start_rolling(speed, bonus_speed, p_spec, b_spec, bonus_dices, laser)
~ temp player_result = player_dice - p_char
Результат: {player_dice} (выпало) - {p_char} (характеристика) = {player_result}.

{ opponent_result == player_result:
    Результаты равны. Уходим на повторный бросок.
    ~ return start_opposite_rolling(o_char, p_char, speed, bonus_speed, p_spec, o_spec, b_spec, bonus_dices, laser)
}

{ laser == true:
    ~ return player_result < opponent_result
- else:
    ~ return player_result > opponent_result
}
