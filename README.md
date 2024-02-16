# Лабораторная работа №2
## Задача на разминку
#### Заданы два целых числа. Найдите их сумму `x + y`, разность `x - y`, произведение `x * y`.
#### **Входные данные**: Два аргумента скрипта в виде `bash script.bash 5 3`

## Решение разминочной задачи
#### Создадим файл и изменим его используя команды:
```
touch script.bash
gedit script.bash
```
После напишем в нашем файле:
```
#!/bin/bash

x=$1
y=$2

plus=$((x+y))
minus=$((x-y))
multiplication=$((x*y))

echo $plus $minus $multiplication
```
Мы считываем две переменные, которые передаются при вызове команды `bash script.bash 5 3`. После создаем еще 3 пременные:
- plus
- minus
- multiplication
#### И в каждой перменной присваеваем число предварительно произведя какую-либо операцию. После командой echo выводим все 3 перменные к терминал

## Задание
#### На основе изученного материала лабораторной работы, лекций, дополнительных источников напишите скрипт, который на вход принимает IPv4-адрес в десятичном формате, а на выходе обеспечивает данный IP-адрес в двоичном формате.
#### Пример входных данных: `192.168.10.1`
#### Пример выходных данных: `11000000.10101000.00001010.00000001`

##Решение
#### Для начал необходимо разделить каждое число `192.168.10.1` по точкам и запишем его в массив `numbers`
```
numbers=($(echo $ip | tr "." " "))
```
#### Создадим функцию binarIp, которая будет переводить число в двоичную системы счислений
```
binarIp(){ # function to convert from binary to decimal
	echo "obase=2; $1" | bc
}
```
Разберемся, что делает строка `echo "obase=2; $1" | bc`:
- `echo` выводит конвертированные данные
- `obase=2` Это опция для команды bc, которая устанавливает двоичную систему счисления, что указывает bc на то, что мы хотим выводить результат в двоичном формате.
- `$1`: Это первый аргумент, переданный в функцию.

#### Далее используя цикл for пройдемся по массиву `numbers` и применим к нему функцию `binarIp`. Получим код, который будет иметь вид:
```
for ((i=0; i<4; i++ )); do 3
 	if [[ $i -eq 3 ]]; then  
 		bin=$(binarIp ${numbers[i]})
        	printf "%08d\n" $bin
 	else  
 		bin=$(binarIp ${numbers[i]})
        	printf "%08d." $bin
 		
 	fi
 done
```
Разберемся, как работает наш цикл:
- Проходим по каждому i-у элементу массива `numbers`
- Проверяем в конструкции if является ли элемент 3-им (иначе говоря последним)
- Если не является, то вызываем функцию `binarIp` и выводим ее добавляя 0, если полученное число цифр меньше 8 и в конце пишм `.`
- Если является, то также вызываем функциб `binarIp` и выводим ее, но в конце не ставим `.`

### Получим:
```
#!/bin/bash

ip=$@
numbers=($(echo $ip | tr "." " ")) #Create list with words strip by dot

binarIp(){ # function to convert from binary to decimal
	echo "obase=2; $1" | bc
}

for ((i=0; i<4; i++ )); do 3
 	if [[ $i -eq 3 ]]; then  
 		bin=$(binarIp ${numbers[i]})
        	printf "%08d\n" $bin
 	else  
 		bin=$(binarIp ${numbers[i]})
        	printf "%08d." $bin
 		
 	fi
 done
```
