# encoding: UTF-8
# language: ru


Функционал: Обзор заявки и комментирование

  @prod4
  Сценарий: S7
    И Проделывает дикую хрень

  @prod
  Сценарий: Сохранение документов и комментирование
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива
    И Запоминает номер новой заявки на аккредитив
    Допустим "Пользователь 3" открывает страницу с формой поиска заявки по номеру
    И Вводит номер новой заявки
    И Нажимает на кнопку "Найти"
    Тогда Пользователя перенаправляет на страницу заявки
    И Подтверждает заявку на аккредитив
    Тогда Заявка подтверждена

    Допустим "Пользователь 3" открывает страницу для раскрытия новой заявки
    И Указывает Email "username@gmail.com"
    И Прикладывает "первый" документ раскрытия
    И Нажимает на кнопку Создать
    Тогда Видит что "первый" документ раскрытия добавлен

    Допустим "Пользователь 6" открывает сводную страницу заявки
    И Сохраняет копию договора купли-продажи
    И Сохраняет прикрепленный файл заявления
    И Сохраняет документ раскрытия
#   И Оставляет пустое поле - Комментарий
    И Нажимает на кнопку - Отправить
    Тогда Видит что оставлен комментарий с текстом "Отсутствует"
    Тогда Видит что комментарий оставлен владельцем аккаунта
    Тогда Видит что дата оставления комментария соответсвует текущей
    Тогда Видит сообщение "Комментарий отправлен"
    И Вводит комментарий "Комментарий"
    И Нажимает на кнопку - Отправить
    Тогда Видит что оставлен комментарий с текстом "Комментарий"
    Тогда Видит сообщение "Комментарий отправлен"
