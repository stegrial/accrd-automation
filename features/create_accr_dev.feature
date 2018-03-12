# encoding: UTF-8
# language: ru


Функционал: Способ покупки "У застройщика"

  @prod
  Сценарий: Существующий Номер счета продавца (20 цифр)
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива
    Тогда Всего к оплате "3 000 ₽"
    Тогда Комисия составляет "3 001 ₽"

  @prod
  Сценарий: Баланс счета
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Выбирает "**** 0000" зарплатный счет
    Тогда Комисия составляет "3 000 ₽"
    Тогда Всего к оплате "3 000 ₽"
    Тогда Видит ошибку "Не хватает 3 001 ₽"

  @prod
  Сценарий: Сумма аккредитива
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет значение поля "Сумма аккредитива"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Сумма аккредитива" не заполнено или заполнено неверно
    И Вводит сумму акредетива "Qq-Йй. #_!"
    Тогда Видит что поле "Сумма аккредитива" осталось пустым
    И Вводит сумму акредетива "0"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Сумма аккредитива" не заполнено или заполнено неверно

  @prod
  Сценарий: Адрес приобретаемой недвижимости
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет значение поля "Адрес приобретаемой недвижимости"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Адрес приобретаемой недвижимости" не заполнено или заполнено неверно

  @prod
  Сценарий: Номер договора
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет значение поля "Номер договора"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Дата договора
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет значение поля "Дата договора"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Дата договора" не заполнено или заполнено неверно
    И Указывает дату договора "Qq-Йй. #_!"
    Тогда Видит что поле "Дата договора" осталось пустым
    И Указывает дату договора "32.12.2016"
    Тогда Видит сообщение "Неверная дата"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Дата договора" не заполнено или заполнено неверно
    И Указывает дату договора "31.13.2016"
    Тогда Видит сообщение "Неверная дата"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Дата договора" не заполнено или заполнено неверно
    И Указывает дату договора "31.13.0000"
    Тогда Видит сообщение "Неверная дата"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Дата договора" не заполнено или заполнено неверно
    И Указывает дату договора "1"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Дата договора" не заполнено или заполнено неверно
    Тогда Видит сообщение "Неверная дата"

  @prod
  Сценарий: Выбор Даты договора из календаря
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Кликает на поле Дата договора
    Тогда Видит календарь на текущий месяц и год
    И Нажимает в календаре на "двойную стрелку - назад"
    Тогда Видит что год изменился на предыдущий
    И Нажимает в календаре на "двойную стрелку - вперед"
    Тогда Видит календарь на текущий месяц и год
    И Нажимает в календаре на "одинарную стрелку - назад"
    Тогда Видит что месяц изменился на предыдущий
    И Нажимает в календаре на "одинарную стрелку - вперед"
    Тогда Видит календарь на текущий месяц и год
    И Выбирает в календаре текущее число месяца
    Тогда Видит в поле "Дата договора" текущую дату
    И Кликает на поле Дата договора
    Тогда Видит календарь с выбранной датой

  @prod
  Сценарий: Наименование договора
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет значение поля "Наименование договора"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Наименование договора" не заполнено или заполнено неверно

  @prod
  Сценарий: Копия договора купли-продажи
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет прикрепленный файл копии договора купли-продажи
    Тогда Видит что файл копии договора купли-продажи удален
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что документ "Копия договора купли-продажи" обязателен

  @prod
  Сценарий: Условия исполнения договора
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет значение поля "Условия исполнения договора"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Условия исполнения договора" не заполнено или заполнено неверно

  @prod
  Сценарий: Номер счета продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет в поле "Номер счета продавца" последнюю цифру
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Номер счета продавца" не заполнено или заполнено неверно
    И Удаляет значение поля "Номер счета продавца"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Номер счета продавца" не заполнено или заполнено неверно
    И Вводит номер счета продавца "Qq-Йй. #_!"
    Тогда Видит что поле "Номер счета продавца" осталось пустым
    И Вводит номер счета продавца "1111122222333334444"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Номер счета продавца" не заполнено или заполнено неверно
    И Вводит номер счета продавца "1111122222333334444455555"
    Тогда Видит в поле "Номер счета продавца" номер "11111222223333344444"
    Тогда Видит сообщение "Далее необходимо указать полные реквизиты получателя"

  @prod
  Сценарий: Существующий ИНН продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 2"
    Тогда Видит что поле "Наименование организации продавца" заполнено и недоступно
    Тогда Видит что поле "ОГРН организации продавца" заполнено и недоступно
    Тогда Видит что поле "Адрес организации продавца" заполнено и недоступно
    Тогда Комисия составляет "3 000 ₽"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Несуществующий ИНН продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 3"
    И Удаляет в поле "ИНН продавца юр.лица" последнюю цифру
    Тогда Видит что поле "Наименование организации продавца" не заполнено и недоступно
    Тогда Видит что поле "ОГРН организации продавца" не заполнено и недоступно
    Тогда Видит что поле "Адрес организации продавца" не заполнено и недоступно
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
#    Тогда Видит что поле "ИНН продавца юр.лица" не заполнено или заполнено неверно
    И Удаляет значение поля "ИНН продавца юр.лица"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
#    Тогда Видит что поле "ИНН продавца юр.лица" не заполнено или заполнено неверно
    И Вводит ИНН продавца юр.лица "Qq-Йй. #_!"
    Тогда Видит что поле "ИНН продавца юр.лица" осталось пустым
    И Вводит ИНН продавца юр.лица "123456789"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
#    Тогда Видит что поле "ИНН продавца юр.лица" не заполнено или заполнено неверно
    И Вводит ИНН продавца юр.лица "123456789011111"
    Тогда Видит в поле "ИНН продавца юр.лица" номер "1234567890"
    Тогда Видит что поле "Наименование организации продавца" не заполнено но доступно
    Тогда Видит что поле "ОГРН организации продавца" не заполнено но доступно
    Тогда Видит что поле "Адрес организации продавца" не заполнено но доступно
    Тогда Видит сообщение "Далее необходимо указать полные реквизиты получателя"

  @prod
  Сценарий: Наименование организации продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 3"
    И Удаляет значение поля "Наименование организации продавца"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Наименование организации продавца" не заполнено или заполнено неверно
    Тогда Видит сообщение "Далее необходимо указать полные реквизиты получателя"

  @prod
  Сценарий: Адрес организации продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 3"
    И Удаляет значение поля "Адрес организации продавца"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Адрес организации продавца" не заполнено или заполнено неверно
    Тогда Видит сообщение "Далее необходимо указать полные реквизиты получателя"

  @prod
  Сценарий: ОГРН организации продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 3"
    И Удаляет значение поля "ОГРН организации продавца"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "ОГРН организации продавца" не заполнено или заполнено неверно
    Тогда Видит сообщение "Далее необходимо указать полные реквизиты получателя"
    Тогда Видит сообщение "ОГРН должен состоять из 13 цифр"
    И Вводит ОГРН организации продавца "Qq-Йй. #_!"
    Тогда Видит что поле "ОГРН организации продавца" осталось пустым
    И Вводит ОГРН организации продавца "111222333444"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "ОГРН организации продавца" не заполнено или заполнено неверно
    Тогда Видит сообщение "Далее необходимо указать полные реквизиты получателя"
    Тогда Видит сообщение "ОГРН должен состоять из 13 цифр"
    И Вводит ОГРН организации продавца "111222333444566"
    Тогда Видит в поле "ОГРН организации продавца" номер "1112223334445"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @test
  Сценарий: БИК банка продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 3"
    И Удаляет в поле "БИК банка продавца" последнюю цифру
    Тогда Видит что поле "Название банка продавца" не заполнено и недоступно
    Тогда Видит что поле "Корреспондентский счет банка продавца" не заполнено и недоступно
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
#    Тогда Видит что поле "БИК банка продавца" не заполнено или заполнено неверно
    И Удаляет значение поля "БИК банка продавца"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
#    Тогда Видит что поле "БИК банка продавца" не заполнено или заполнено неверно
    И Вводит БИК банка продавца "Qq-Йй. #_!"
    Тогда Видит что поле "БИК банка продавца" осталось пустым
    И Вводит БИК банка продавца "11112222"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
#    Тогда Видит что поле "БИК банка продавца" не заполнено или заполнено неверно
    И Вводит БИК банка продавца "111222333444"
    Тогда Видит в поле "БИК банка продавца" номер "111222333"
    Тогда Видит что поле "Название банка продавца" не заполнено и недоступно
    Тогда Видит что поле "Корреспондентский счет банка продавца" не заполнено и недоступно
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "БИК банка продавца" не заполнено или заполнено неверно
    Тогда Видит сообщение "Банк не найден, введите корректный БИК"
    И Вводит БИК банка продавца "044525580"
    Тогда Видит что поле "Название банка продавца" заполнено и недоступно
    Тогда Видит что поле "Корреспондентский счет банка продавца" заполнено и недоступно
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Изменение существующего Номера счета продавца (20 цифр)
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Вводит номер счета продавца "11111222223333344444"
    Тогда Видит что поле "ИНН продавца юр.лица" осталось пустым
    Тогда Видит что поле "Наименование организации продавца" не заполнено и недоступно
    Тогда Видит что поле "ОГРН организации продавца" не заполнено и недоступно
    Тогда Видит что поле "Адрес организации продавца" не заполнено и недоступно
    Тогда Видит что поле "БИК банка продавца" осталось пустым
    Тогда Видит что поле "Название банка продавца" не заполнено и недоступно
    Тогда Видит что поле "Корреспондентский счет банка продавца" не заполнено и недоступно
    И Вводит ИНН продавца юр.лица "7714813251"
    И Вводит БИК банка продавца "044525580"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Изменение несуществующего Номера счета продавца (20 цифр)
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 2"
    И Вводит номер счета продавца "44444333332222211111"
    Тогда Видит что поле "ИНН продавца юр.лица" осталось пустым
    Тогда Видит что поле "Наименование организации продавца" не заполнено и недоступно
    Тогда Видит что поле "ОГРН организации продавца" не заполнено и недоступно
    Тогда Видит что поле "Адрес организации продавца" не заполнено и недоступно
    Тогда Видит что поле "БИК банка продавца" осталось пустым
    Тогда Видит что поле "Название банка продавца" не заполнено и недоступно
    Тогда Видит что поле "Корреспондентский счет банка продавца" не заполнено и недоступно
    И Вводит ИНН продавца юр.лица "7714813251"
    И Вводит БИК банка продавца "044525580"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Изменение существующего ИНН продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 2"
    И Вводит ИНН продавца юр.лица "1234567890"
    Тогда Видит что поле "Наименование организации продавца" не заполнено но доступно
    Тогда Видит что поле "ОГРН организации продавца" не заполнено но доступно
    Тогда Видит что поле "Адрес организации продавца" не заполнено но доступно
    И Вводит Наименование организации продавца "Имя ОП"
    И Вводит ОГРН организации продавца "1112223334445"
    И Вводит Адрес организации продавца "Адрес ОП"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Изменение несуществующего ИНН продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 3"
    И Вводит ИНН продавца юр.лица "0987654321"
    Тогда Видит что поле "Наименование организации продавца" не заполнено но доступно
    Тогда Видит что поле "ОГРН организации продавца" не заполнено но доступно
    Тогда Видит что поле "Адрес организации продавца" не заполнено но доступно
    И Вводит Наименование организации продавца "Имя ОП"
    И Вводит ОГРН организации продавца "1112223334445"
    И Вводит Адрес организации продавца "Адрес ОП"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Изменение существующего БИК банка продавца
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 2"
    И Вводит БИК банка продавца "111222333"
    Тогда Видит что поле "Название банка продавца" не заполнено и недоступно
    Тогда Видит что поле "Корреспондентский счет банка продавца" не заполнено и недоступно
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "БИК банка продавца" не заполнено или заполнено неверно

  @prod
  Сценарий: Изменение способа покупки
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Выбирает способ покупки "Через агентство"
    Тогда Видит что поле "Номер счета продавца" осталось пустым
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле "Номер счета продавца" не заполнено или заполнено неверно

  @prod
  Сценарий: Подписанный скан заявления
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Удаляет прикрепленный файл заявления
    Тогда Видит что прикрепленный файл заявления удален
    И Проверяет незаполненные поля
    Тогда Видит что документ "Подписанный скан заявления" обязателен

  @prod
  Сценарий: Страница предпросмотра заявки
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива
    И Сохраняет копию договора купли-продажи
    И Сохраняет прикрепленный файл заявления
    И Нажимает на кнопку Новая покупка
    Тогда Пользователя перенаправляет на страницу создания аккредетива

  @prod
  Сценарий: Срок действия аккредитива
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Запоминает установленный срок действия аккредитива
    И Удаляет значение поля "Срок действия аккредитива"
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле Срок действия аккредитива не заполнено или заполнено неверно
    Тогда Видит сообщение о допустимом сроке действия аккредитива
    И Указывает срок действия аккредитива "Qq-Йй. #_!" дней
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле Срок действия аккредитива не заполнено или заполнено неверно
    Тогда Видит сообщение о допустимом сроке действия аккредитива
    И Указывает срок действия аккредитива "0" дней
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле Срок действия аккредитива не заполнено или заполнено неверно
    Тогда Видит сообщение о допустимом сроке действия аккредитива
    И Указывает срок действия аккредитива "max" дней
    Тогда Видит что кнопки "Распечатать,Приложить" недоступны
    И Проверяет незаполненные поля
    Тогда Видит что поле Срок действия аккредитива не заполнено или заполнено неверно
    Тогда Видит сообщение о допустимом сроке действия аккредитива

  @prod
  Сценарий: ФИО второго покупателя (при наличии)
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 4"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива

  @prod
  Сценарий: Проверка расчета комиссии
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Выбирает способ покупки "У застройщика"
    И Вводит номер счета продавца "40702810900001000573"
    И Выбирает "**** 1405" зарплатный счет
    И Вводит сумму акредетива "999500"
    Тогда Комисия составляет "2 000 ₽"
    И Вводит сумму акредетива "1000500"
    Тогда Комисия составляет "2 001 ₽"
    И Вводит сумму акредетива "2999500"
    Тогда Комисия составляет "5 999 ₽"
    И Вводит сумму акредетива "3000500"
    Тогда Комисия составляет "6 000 ₽"


  @prod
  Сценарий: Соответствие введенных данных (способ покупки - У застройщика)
    Допустим "Пользователь 3" открывает страницу с формой создания заявки на аккредитив
    И Заполняет форму используя способ покупки - У застройщика и "набор данных 1"
    И Открывает аккредитив
    Тогда Пользователя перенаправляет на страницу аккредетива
    Тогда Всего к оплате "3 000 ₽"
    Тогда Комисия составляет "3 001 ₽"

