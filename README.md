# Введение в анализ данных

Привет. Это репозиторий курса "Введение в анализ данных" на экономическом факультете МГУ. Здесь будут выкладываться некоторые домашние задания.

## Первое домашнее задание (срок: 23:59 14 февраля)

1. Установите последнюю версию R на свою операционную систему по [ссылке](https://cran.rstudio.com)

2. Скачайте RStidio Open Source Edition по [ссылке](https://www.rstudio.com/products/RStudio)

3. Выполните следующие команды в RStudio

```R
install.packages("swirl")
library(swirl)
swirl::install_course_url('https://raw.githubusercontent.com/go95/practical_econometrics/master/student_files/R_Programming.zip')
swirl()
```

Таким образом вы установите интерактивную домашнюю работу, которую вам необходимо пройти. Как ее сдать, выясните в конце работы :)


Из предложенных tutorials рекомендуется пройти:
1. Basic Building Blocks (оценивается 1 балл)
2. Workspace and Files (рекомендуется, но не оценивается)
3. Sequences of Numbers (оценивается 1 балл)
4. Vectors (рекомендуется, но не оценивается)
5. Missing Values (оценивается 1 балл)
6. Subsetting Vectors (оценивается 1 балл)
7. Matrices and Data Frames (оценивается 1 балл)


## Второе домашнее задание (срок: 23:59 21 февраля)

Выполните следующие команды в RStudio

```R
library(swirl)
swirl()
```
Из предложенных tutorials рекомендуется пройти:

8. Logic  (оценивается 1 балл)
10. lapply and sapply  (оценивается 1 балл)
11. vapply and tapply  (оценивается 1 балл)
12. Looking at Data  (оценивается 1 балл)
14. Dates and Times  (оценивается 1 балл)


## Третье домашнее задание (срок: 23:59 28 февраля) (5 баллов)

Это первая часть длинного проекта, на основе которого мы будем учиться писать чистый код и использовать функции в R

0. Вам понадобится установить пакет

```
install.packages('lintr')
```

1.Скачайте данные с публикациями Atila Abdulkadiroglu из Duke University c помощью команды

```R
articles <- read.csv(url("https://raw.githubusercontent.com/go95/practical_econometrics/master/Abdulkadiroglou.csv"))
```

2. Посчитайте Индекс Хирша для Atila Abdulkadiroglu

> Учёный имеет индекс h, если h из его Np статей цитируются как минимум h раз каждая, в то время как оставшиеся (Np — h) статей цитируются не более чем h раз каждая.

Ваш код должен иметь формат .R, должен проходить проверку на Tidyverse Style Guide. Вы можете это проверить с помощью команды:

```R
library(lintr) # импорт (активация) пакета
lint("your_file.R")
```

Ваш код должен считать все промежуточные результаты, импортировать все необходимые пакеты с помощью команды library, не содержать команд install.package и запускаться из файла с помощью команды

```R
source('your_file.R')
```

В качестве результата эта команда должна печатать одно число: Индекс Хирша Atila Abdulkadiroglu

3. Сдать код: https://goo.gl/forms/F7mzTH6jESmY2AMj1 

## Четвертое домашнее задание (срок: 23:59 14 марта) (10 баллов)

В рамках этого домашнего задания мы соберем таблицу, которую будем использовать на дальнейших занятиях для того, чтобы исследовать, как расстояния между соавторами связаны с их совместной академической активностью. Единицей наблюдения будет пара авторов в определенный год.

0. Вам понадобится установить пакет

```R
install.packages('scholar')
```

1. Скачайте список Google Scholar ID исследуемых исследователей (вполне уместный каламбур).

```R
scholars <- read.csv(url("https://raw.githubusercontent.com/go95/practical_econometrics/master/google_scholar_ids.csv"), as.is = TRUE)
```

2. Воспольуйтесь функциями get_publications и get_profile из пакета scholar, чтобы собрать data.frame с полями author1, author2, university1, university2 year, n_joint_publications.

```R
get_bibliographical_data <- function (scholars) {
  # YOUR CODE HERE
  return(data)
}
```

В время выполнения домашнего задания пользуйтесь пакетами reshape2 и dplyr. Также в какой-то момент вам может понадобиться функция strsplit.

Ваш код должен иметь формат .R, должен проходить проверку на Tidyverse Style Guide.

Ваш код должен считать все промежуточные результаты, импортировать все необходимые пакеты с помощью команды library, не содержать команд install.package и запускаться из файла с помощью команды

```R
source('your_file.R')
x <- get_bibliographical_data(scholars)
```

Результатом выполнения этих команд должен быть исходный data.frame, присвоенный переменной x

3. Сдать код: https://goo.gl/forms/d8XBky4t45wvHzen2

## Четвертое домашнее задание, облегченное (срок: 23:59 25 марта) (те же 10 баллов)

В репозитории лежит та часть домашнего задания, которую мы сделали на семинаре. Он определяет функции get_publications_author_pair, get_affiliation_info, format_name, а также скачивает список исследуемых scholars. Документация по этим функциям содержатся непосредственно в коде. Этот код берет сырые данные по публикациям и делает из них промежуточные таблицы. Нам осталась самая простая часть -- сгруппировать эти данные и собрать в один датсет.

0. Вам понадобится установить пакеты

```R
install.packages('pbapply')
install.packages('dplyr')
```

1. Cкачайте файл и выполните с помощью source

```R
download.file("https://raw.githubusercontent.com/go95/practical_econometrics/master/ha4_with_hints.R", destfile = "ha4_with_hints.R")
source("ha4_with_hints.R")

# кстати вот так тоже работает, но файл не создается в рабочей директории
source(url("https://raw.githubusercontent.com/go95/practical_econometrics/master/ha4_with_hints.R"))
```

2. Почитайте код и разберитесь в нем. Обратите внимание, а заодно (этот пункт оценивается

Проверьте его на следование Style guide и исправьте ошибки
```R
lint("ha4_with_hints.R")
```

Воспользуйтесь пакетом pbapply, чтобы заменить печать scholar_ids в функции get_publications_author_pair на Progress bar.
```R
lint("ha4_with_hints.R")
```

Здавайте вопросы, обсуждайте в чатике

3. Получите список публикаций функцией get_publications_author_pair и, воспользовавшись пакетом dplyr сделайте табличку author1 author2 n_joint_publications year

4. Получите список университетов функцией get_affiliation_info

5. Приведите имена авторов к единому формату в обеих таблицах

6. С помощью функции join из пакета dplyr подтяните названия университетов в табилцу вида author1 author2 n_joint_publications year university1 university2

7. Оформите ваш код в функцию get_bibliographical_data так, чтобы его можно было запустить командами

```R
source('your_file.R')
x <- get_bibliographical_data(scholars)
```

Результатом выполнения этих команд должен быть исходный data.frame, присвоенный переменной x

8. (задача со звездочкой) Исправьте функцию get_affiliation_info так, чтобы колонка affiliation не содержала должности исследователя

3. Сдать код: https://goo.gl/forms/d8XBky4t45wvHzen2

## Рекомендации по выполнению Домашнего задания

Если в процессе установки у вас возникли проблемы, не стесняйтесь спросить помощи у товарища (или у товарища семинариста)

Вообще, помощи у товарища не надо стесняться просить. Но если вы будете злоупотреблять этой помощью, у нас есть способы об этом узнать (способы по очевидным причинам не разглашаются)

Если вы застряли, можно использовать функцию skip(), но не злоупотреляйте (можем не зачесть раздел).

## Acknowledgments

Some of the Home Assignments are borrowed from John Hopkins Univerity course in Data Science from Coursera. We thank Roger D. Peng et al. for distributing their Home Assignments under permissive licence.
