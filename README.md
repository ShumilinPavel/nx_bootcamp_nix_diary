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
`bash -c "$(wget -O- https://raw.githubusercontent.com/ShumilinPavel/nx_bootcamp_nix_diary/develop/install.sh)"; . $HOME/diary/diary.sh`

## Удаление
Для удаления выполните следующую команду:  
`bash -c "$(wget -O- https://raw.githubusercontent.com/ShumilinPavel/nx_bootcamp_nix_diary/develop/uninstall.sh)"`

## Пример конфигурации .diaryrc
В директории `~/diary` содержится файл `.diaryrc`, в котором определены перменные окружения для задания параметров работы приложения.
Конфигурация по умолчанию:
```shell
export NOTES_DIR="$HOME/diary/notes"
export TEMPLATES_DIR="$HOME/diary/templates"
export RECYCLE_BIN_DIR="$HOME/diary/recycle-bin"
export TEXT_EDITOR="nano"
```
Первые 3 перменные задают директории для хранения записей, шаблонов и удаленных записей соответственно.
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