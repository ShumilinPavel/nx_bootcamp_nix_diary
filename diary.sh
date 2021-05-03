#!/bin/bash

diary() {
    __generateFileName() {
        year=$(date +%Y)
        month=$(date +%m)
        directoryName="$NOTES_DIR/$year/$month"
        if [ ! -d $directoryName ]
        then
            mkdir -p $directoryName
        fi
        id=$(uuidgen)
        timestamp=$(date +%Y-%m-%d_%H-%M)
        echo "$directoryName/${id}___$timestamp.md"
    }

    __createNote() {
        $TEXT_EDITOR $(__generateFileName)
    }

    __help() {
        echo 
"Templates are located in '$TEMPLATES_DIR'
Notes can be matched by some first characters of the id

Available commands:

diary new                   Create new note
diary new -t <template>     Create new note from <template> file

diary open <id>             Open note by <id>
diary stats                 Show diary statistics
diary delete <id>           Move note with <id> to recycle bin
diary bin                   Show notes in recycle bin
diary restore <id>          Restore note from recycle-bin
diary backup                Make diary.tar.gz with notes
diary head                  Show last 5 notes head

diary list
diary list -r(removed)"
    }

    __createFromTemplate() {
        template=$1
        if [ ! -f "$TEMPLATES_DIR/$1" ]
        then
            echo "'$template' template file not found"
        else
            fileName=$(__generateFileName)
            cp "$TEMPLATES_DIR/$template" $fileName
            $TEXT_EDITOR $fileName
        fi
    }

    __showStats() {
        totalNotes=$(find $NOTES_DIR -type f | wc -l)
        echo "Total notes: $totalNotes"
        lastNoteCreationTime=$(find $NOTES_DIR -type f -printf "%f\n" | cut -c 40-55 | sort -n | tail -n 1)
        echo "Last note creation time: $lastNoteCreationTime"
    }

    __backup() {
        tar czf diary-backup.tar.gz $NOTES_DIR $TEMPLATES_DIR $RECYCLE_BIN_DIR
        echo "Created backup 'diary-backup.tar.gz'"
    }

    __createDefaultRcFile() {
        rcFile="$HOME/diary/.diaryrc"
        echo "export NOTES_DIR=\"$HOME/diary/notes\"" > $rcFile
        echo "export TEMPLATES_DIR=\"$HOME/diary/templates\"" >> $rcFile
        echo "export RECYCLE_BIN_DIR=\"$HOME/diary/recycle-bin\"" >> $rcFile
        echo "export TEXT_EDITOR=\"nano\"" >> $rcFile
        echo "Created default config file '$rcFile'"
    }

    __openNoteById() {
        id=$1
        file=$(find $NOTES_DIR -name "$id*")
        fileCount=$(find $NOTES_DIR -name "$id*" | wc -l)
        if [[ $fileCount == 1 ]]
        then
            $TEXT_EDITOR $file
        elif [[ $fileCount = 0 ]]
        then
            echo "Note not found"
        else
            echo "Too many notes are matched. Enter id more precisely"
        fi
    }

    __deleteNoteById() {
        id=$1
        file=$(find $NOTES_DIR -name "$id*")
        fileCount=$(find $NOTES_DIR -name "$id*" | wc -l)
        if [[ $fileCount == 1 ]]
        then
            if [[ ! -d $RECYCLE_BIN_DIR ]]
            then
                mkdir -p $RECYCLE_BIN_DIR
            fi
            mv $file $RECYCLE_BIN_DIR
        elif [[ $fileCount = 0 ]]
        then
            echo "Note not found"
        else
            echo "Too many notes are matched. Enter id more precisely"
        fi
    }


    #### MAIN ####
    if [[ ! -f "$HOME/diary/.diaryrc" ]]
    then
        echo "config file '$HOME/diary/.diaryrc' not found" 
        __createDefaultRcFile
    fi

    source "$HOME/diary/.diaryrc"

    if [[ $# -eq 0 || $# -eq 1 && ($1 = "-h" || $1 = "--help" || $1 = "help") ]]
    then
        __help
    elif [[ $# -eq 1 && $1 = "new" ]]
    then
        __createNote
    elif [[ $# -eq 3 && $1 = "new" && $2 = '-t' ]]
    then
        __createFromTemplate $3
    elif [[ $# -eq 1 && $1 = "stats" ]]
    then
        __showStats
    elif [[ $# -eq 1 && $1 = "backup" ]]
    then
        __backup
    elif [[ $# -eq 2 && $1 = "open" ]]
    then
        __openNoteById $2
    elif [[ $# -eq 2 && $1 = "delete" ]]
    then
        __deleteNoteById $2
    fi

    echo "complete"
}


