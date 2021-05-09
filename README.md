# Diary

Репозиторий содержит прототип CLI-приложения для ведения дневника.

Приложение позволяет создавать, просматривать и удалять записи.
Записи представляют собой файлы Mardown, создание которых также возможно на основе шаблонов.
Удаление записей перемещает их в корзину.

## Зависимости
Для работы приложению необходимы следующие зависимости:
- uuidgen (установка: `sudo apt-get install uuid-runtime`)
- git (установка: `sudo apt-get install git`)

## Установка
Для установки выполните следующую команду:  
```
bash -c "$(wget -O- https://raw.githubusercontent.com/ShumilinPavel/nx_bootcamp_nix_diary/master/install.sh)"; . $HOME/diary/diary.sh
```

## Удаление
Для удаления выполните следующую команду:  
```
bash -c "$(wget -O- https://raw.githubusercontent.com/ShumilinPavel/nx_bootcamp_nix_diary/master/uninstall.sh)"
```

## Пример конфигурации .diaryrc 
В директории `~/diary` содержится файл `.diaryrc`, в котором определены перменные окружения для задания параметров работы приложения.
Конфигурация по умолчанию:
```shell
export NOTES_DIR="$HOME/diary/notes"
export TEMPLATES_DIR="$HOME/diary/templates"
export RECYCLE_BIN_DIR="$HOME/diary/recycle-bin"
export TEXT_EDITOR="nano"
```
Первые три перменные задают директории для хранения записей, шаблонов и удаленных записей соответственно.
Переменная `TEXT_EDITOR` определяет тектовый редактор, с помощью которого будет вестить работа с записями.

## Примеры команд
```
shumilin@DESKTOP-VTF39FM:~$ diary help
Templates are located in '/home/shumilin/diary/templates'
Notes can be matched by some first characters of the id

Available commands:

diary new                   Create new note
diary new -t <template>     Create new note from <template> file
diary open <id>             Open note by <id>
diary stats                 Show diary statistics
diary delete <id>           Move note with <id> to recycle bin
diary bin                   Show notes in recycle bin
diary restore <id>          Restore note from recycle bin
diary backup                Make 'diary.tar.gz' with notes, templates and recycle bin if exists
diary head                  Show last 5 notes head
diary list                  List all notes
```
Имена файлов генерируется по схеме: `$NOTES_DIR/year/month/ID__yyyy-mm-dd_HH-MM.md`
Для открытия записи достаточно указать несколько первых символов ID, которые однозначно определяют запись.
Например, если `diary list` выводит следующий результат,
```
shumilin@DESKTOP-VTF39FM:~$ diary list
/home/shumilin/diary/notes/2021/05/8e657586-6240-4a0d-a88e-52eb27412870___2021-05-04_14-34.md
/home/shumilin/diary/notes/2021/05/f2554170-05ed-4571-b3f0-fbb50548fe4b___2021-05-04_14-31.md
/home/shumilin/diary/notes/2021/05/83662263-1f0e-4e30-966d-d3708f7aa238___2021-05-04_14-35.md
```
то открыть запись с ID `8e657586-6240-4a0d-a88e-52eb27412870` можно, например, последними тремя командами,
но не первой, так как существуют две записи, ID которых начинаются с `8`.
 ```
shumilin@DESKTOP-VTF39FM:~$ diary open 8
Too many notes are matched. Enter id more precisely
shumilin@DESKTOP-VTF39FM:~$ diary open 8e
shumilin@DESKTOP-VTF39FM:~$ diary open 8e6
shumilin@DESKTOP-VTF39FM:~$ diary open 8e65
```
Другие примеры использования команд:
```
shumilin@DESKTOP-VTF39FM:~$ diary stats
Total notes: 3
Last note creation time: 2021-05-04_14-35

shumilin@DESKTOP-VTF39FM:~$ diary bin
/home/shumilin/diary/recycle-bin/3e6e7536-bb77-4226-82ae-ce0b6a636fec___2021-05-04_14-32.md
/home/shumilin/diary/recycle-bin/2e4c3539-86bd-4a1e-9f5e-f9c17faccbec___2021-05-04_14-32.md
/home/shumilin/diary/recycle-bin/97389f22-b187-4298-b317-b6545212e04a___2021-05-04_14-35.md
/home/shumilin/diary/recycle-bin/203d597e-9309-4fab-8d9a-0b85f632f91b___2021-05-04_14-35.md
/home/shumilin/diary/recycle-bin/00dc878d-c543-4e70-8fa1-d71f7ec8e4bc___2021-05-04_14-32.md

shumilin@DESKTOP-VTF39FM:~$ diary head
f2554170   2021-05-04   hello world
8e657586   2021-05-04   some text
83662263   2021-05-04   hello

shumilin@DESKTOP-VTF39FM:~$ diary backup
tar: Removing leading `/' from member names
tar: Removing leading `/' from hard link targets
Created backup 'diary-backup.tar.gz'

shumilin@DESKTOP-VTF39FM:~$ ls diary-backup.tar.gz 
diary-backup.tar.gz

shumilin@DESKTOP-VTF39FM:~$ tar tvf diary-backup.tar.gz 
drwxr-xr-x shumilin/shumilin 0 2021-05-04 14:31 home/shumilin/diary/notes/
drwxr-xr-x shumilin/shumilin 0 2021-05-04 14:31 home/shumilin/diary/notes/2021/
drwxr-xr-x shumilin/shumilin 0 2021-05-04 14:45 home/shumilin/diary/notes/2021/05/
-rw-r--r-- shumilin/shumilin 10 2021-05-04 14:35 home/shumilin/diary/notes/2021/05/8e657586-6240-4a0d-a88e-52eb27412870___2021-05-04_14-34.md
-rw-r--r-- shumilin/shumilin 12 2021-05-04 14:32 home/shumilin/diary/notes/2021/05/f2554170-05ed-4571-b3f0-fbb50548fe4b___2021-05-04_14-31.md
-rw-r--r-- shumilin/shumilin  6 2021-05-04 14:35 home/shumilin/diary/notes/2021/05/83662263-1f0e-4e30-966d-d3708f7aa238___2021-05-04_14-35.md
drwxr-xr-x shumilin/shumilin  0 2021-05-04 14:31 home/shumilin/diary/templates/
-rw-r--r-- shumilin/shumilin 73 2021-05-04 14:31 home/shumilin/diary/templates/checklist.md
drwxr-xr-x shumilin/shumilin  0 2021-05-04 14:41 home/shumilin/diary/recycle-bin/
-rw-r--r-- shumilin/shumilin 12 2021-05-04 14:32 home/shumilin/diary/recycle-bin/3e6e7536-bb77-4226-82ae-ce0b6a636fec___2021-05-04_14-32.md
-rw-r--r-- shumilin/shumilin 12 2021-05-04 14:32 home/shumilin/diary/recycle-bin/2e4c3539-86bd-4a1e-9f5e-f9c17faccbec___2021-05-04_14-32.md
-rw-r--r-- shumilin/shumilin 15 2021-05-04 14:35 home/shumilin/diary/recycle-bin/97389f22-b187-4298-b317-b6545212e04a___2021-05-04_14-35.md
-rw-r--r-- shumilin/shumilin  5 2021-05-04 14:35 home/shumilin/diary/recycle-bin/203d597e-9309-4fab-8d9a-0b85f632f91b___2021-05-04_14-35.md
-rw-r--r-- shumilin/shumilin 11 2021-05-04 14:32 home/shumilin/diary/recycle-bin/00dc878d-c543-4e70-8fa1-d71f7ec8e4bc___2021-05-04_14-32.md
```
