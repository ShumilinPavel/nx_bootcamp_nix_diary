#!/bin/bash

generateFileName() {
    year=`date +%Y`
    month=`date +%m`
    directory_name="$NOTES_DIR/$year/$month"

    if [ ! -d $directory_name ]
    then
        mkdir -p $directory_name
    fi
    
    id=`uuidgen`
    timestamp=`date +%Y-%m-%d_%H-%M`

    echo "$directory_name/${id}___$timestamp.md"
}

createNote() {
    $TEXT_EDITOR `generateFileName`
}

help() {
    cat << EOF
Available commands:

diary new                   Create new note
diary new [-t <template>]   Create new note from template

diary open <id>             f
diary stats                 f
diary delete <id>           f
diary bin                   f
diary restore <id>          f
diary backup                f
diary head                  f

diary list
diary list -r(removed)
EOF
}

createFromTemplate() {
    template=$1

    if [ ! -f "$TEMPLATES_DIR/$1" ]
    then
        echo "'$template' template file not found"
    else
        fileName=`generateFileName`
        cp "$TEMPLATES_DIR/$template" $fileName
        $TEXT_EDITOR $fileName
    fi
}

showStats() {
    totalNotes=`find $NOTES_DIR -type f | wc -l`
    echo "Total notes: $totalNotes"

    # find . -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f2- | tail -n 1
    lastNoteTime=`find $NOTES_DIR -type f -printf "%f\n" | cut -c 40-55 | sort -n | tail -n 1`
    echo "Last note time creation: $lastNoteTime"
}

backup() {
    tar czf diary-backup.tar.gz --directory=$NOTES_DIR .
    # + архивация шаблонов, rc файла
    echo "Created backup 'diary-backup.tar.gz'"
}

createDefaultRcFile() {
    echo "export NOTES_DIR=\"$HOME/diary\"" > "$HOME/.diaryrc"
    echo "export TEXT_EDITOR=\"nano\"" >> "$HOME/.diaryrc"
    echo "export TEMPLATES_DIR=\"$HOME/diary/templates\"" >> "$HOME/.diaryrc"
    echo "created config file '$HOME/.diaryrc'"
}

openNoteById() {
    id=$1
    file=`find $NOTES_DIR -name "$id*"`
    fileCount=`find $NOTES_DIR -name "$id*" | wc -l`

    if [[ $fileCount == 1 ]]
    then
        $TEXT_EDITOR $file
    elif [[ $fileCount = 0 ]]
    then
        echo "note not found"
    else
        echo "too many notes; enter more precise id"
    fi
}

deleteNoteById() {
    id=$1
    file=`find $NOTES_DIR -name "$id*"`
    fileCount=`find $NOTES_DIR -name "$id*" | wc -l`

    if [[ $fileCount == 1 ]]
    then
        $TEXT_EDITOR $file
    elif [[ $fileCount = 0 ]]
    then
        echo "note not found"
    else
        echo "too many notes; enter more precise id"
    fi
}


#### MAIN ####
if [[ ! -f "$HOME/.diaryrc" ]]
then
    createDefaultRcFile
fi

source "$HOME/.diaryrc"

if [[ $# -eq 0 || $# -eq 1 && ($1 = "-h" || $1 = "--help") ]]
then
    help
elif [[ $# -eq 1 && $1 = "new" ]]
then
    createNote
elif [[ $# -eq 3 && $1 = "new" && $2 = '-t' ]]
then
    createFromTemplate $3
elif [[ $# -eq 1 && $1 = "stats" ]]
then
    showStats
elif [[ $# -eq 1 && $1 = "backup" ]]
then
    backup
elif [[ $# -eq 2 && $1 = "open" ]]
then
    openNoteById $2
fi

echo "complete"
