#!/bin/bash

echo -e "\nEnter your text and press ENTER + CTRL+D:\n"
RAW_INPUT=$(cat)

# Removing special chars to improve the output
INPUT=${RAW_INPUT//[$'\t\r\n']}

echo -e "\n\nPARSED INPUT:\n\n$INPUT\n"

EN=`aws translate translate-text \
    --source-language-code pt \
    --target-language-code en \
    --text "$INPUT" \
    --output text \
    --query "TranslatedText" &`
PT=`aws translate translate-text \
    --source-language-code en \
    --target-language-code pt \
    --text "$INPUT" \
    --output text \
    --query "TranslatedText" &`
ES=`aws translate translate-text \
    --source-language-code pt \
    --target-language-code es \
    --text "$INPUT" \
    --output text \
    --query "TranslatedText" &`
ES_PT=`aws translate translate-text \
    --source-language-code es \
    --target-language-code pt \
    --text "$INPUT" \
    --output text \
    --query "TranslatedText" &`
#wait

echo -e "\n== ENGLISH == \n$EN\n=="
echo -e "\n== PORTUGUESE\n$PT\n=="
echo -e "\n== SPANISH\n$ES\n==\n"
echo -e "\n== PT -> SPANISH\n$ES_PT\n==\n"
