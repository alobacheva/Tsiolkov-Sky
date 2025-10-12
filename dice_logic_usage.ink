INCLUDE dice_logic.ink

Начало игры.
-> test_opponent

=== test_function ===
Тестирование функции.
~ temp result = start_rolling(1, 1, 1, 0, 1, true)
Итоговый результат броска кубов: {result}
->END

=== test_opponent ===
Тестирование оппонентного броска.
~ temp result = start_opposite_rolling(2, 3, 1, 1, 2, 3, 4, 0, true)
Победил: {result: Игрок!|Оппонент =(}
->END
