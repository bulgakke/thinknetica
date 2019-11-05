months = { january: 31, february: 28, march: 31, april: 30, may: 31, june: 30, 
  july: 31, august: 31, september: 30, october: 31, november: 30, december: 31 }
months.each_pair { |month, days| puts month if days == 30 }
# В документации нашёл еще метод .key(30), но он возвращает только первый ключ,
# которому присвоено это значение. Даже если и можно его проитерировать, это будет сложнее моей строчки.
