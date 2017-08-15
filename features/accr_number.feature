# encoding: UTF-8
# language: ru

Функционал: Поиск заявки по номеру и её подтверждение

  Сценарий: Поиск по невалидному номеру заявки
    Допустим "Пользователь 3" открывает страницу с формой поиска заявки по номеру
#   И Оставляет пустое поле поиска
    И Нажимает на кнопку "Найти"
    Тогда Видит что кнопка "Найти" недоступна
    И Вводит "Qq-Йй. #_!"
    И Нажимает на кнопку "Найти"
    Тогда Видит что по номеру заявка не найдена
    Тогда Видит сообщение "Аккредитив с номером Qq-Йй. #_! не найден"

  Сценарий: Поиск по существующему номеру заявки
    Допустим "Пользователь 3" открывает страницу создания аккредетива
    И Вводит номер счета продавца "40702810200001000820"
    И Выбирает "**** 1405" зарплатный счет
    И Вводит сумму акредетива "1"
    И Вводит адрес приобритения недвижимости "Адрес ПН"
    И Вводит номер договора "1"
    И Указывает текущую дату
    И Вводит наименнование договора "Договор"
    И Загружает копию договора купли-продажи
    И Указывает условия исполнения договора "Условия"
    И Распечатывает заявление
    И Прекрепляет файл
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива
    И Запоминает новый номер заявки на аккредитив
    И "Пользователь 3" открывает страницу с формой поиска заявки по номеру
    И Вводит новый номер заявки
    И Нажимает на кнопку "Найти"
    Тогда Пользователя перенаправляет на страницу заявки
    Тогда Видит что номер заявки соответствует искомой

  Сценарий: Поиск по несуществующему номеру заявки
    Допустим "Пользователь 3" открывает страницу создания аккредетива
    И Вводит номер счета продавца "40702810200001000820"
    И Выбирает "**** 1405" зарплатный счет
    И Вводит сумму акредетива "1"
    И Вводит адрес приобритения недвижимости "Адрес ПН"
    И Вводит номер договора "1"
    И Указывает текущую дату
    И Вводит наименнование договора "Договор"
    И Загружает копию договора купли-продажи
    И Указывает условия исполнения договора "Условия"
    И Распечатывает заявление
    И Прекрепляет файл
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива
    И Запоминает новый номер заявки на аккредитив
    И "Пользователь 3" открывает страницу с формой поиска заявки по номеру
    И Вводит несуществующий номер заявки
    И Нажимает на кнопку "Найти"
    Тогда Видит что по номеру заявка не найдена

  Сценарий: Подтверждение заявки
    Допустим "Пользователь 3" открывает страницу создания аккредетива
    И Вводит номер счета продавца "40702810200001000820"
    И Выбирает "**** 1405" зарплатный счет
    И Вводит сумму акредетива "10"
    И Вводит адрес приобритения недвижимости "Адрес ПН"
    И Вводит номер договора "1"
    И Указывает текущую дату
    И Вводит наименнование договора "Договор"
    И Загружает копию договора купли-продажи
    И Указывает условия исполнения договора "Условия"
    И Распечатывает заявление
    И Прекрепляет файл
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива
    И Запоминает новый номер заявки на аккредитив
    И "Пользователь 3" открывает страницу с формой поиска заявки по номеру
    И Вводит новый номер заявки
    И Нажимает на кнопку "Найти"
    Тогда Пользователя перенаправляет на страницу заявки
    И Сохраняет - Копию договора купли продажи
    И Сохраняет - Копию анкеты
    И Нажимает на кнопку Редактировать
    Тогда Пользователя перенаправляет на страницу с формой для редактирования заявки
    Тогда Видит что форма заполнена
    И Вводит сумму акредетива "1"
    И Подтверждает изменения
    Тогда Пользователя перенаправляет на страницу заявки
    Тогда Пользователь видит что сумма аккредитива изменена
    И Нажимает на кнопку Подтвердить
    Тогда Заявка подтверждена

  Сценарий: Перейти к поиску заявки по ФИО
    Допустим "Пользователь 3" открывает страницу с формой поиска заявки по номеру
    И Переходит по ссылке - Поиск заявки для раскрытия
    Тогда Пользователя перенаправляет на страницу с формой поиска по ФИО
