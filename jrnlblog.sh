#!/bin/bash
#
# JRNLblog : make a static website (blog) from
# your journal.txt file made with jrnl
#
# TODO : scp / lftp intégration
#
echo "-------------------------------"
echo "JRNLblog.sh by Nicolas Lorenzon"
echo "-------------------------------"

# don't modify this
# first we take the tag to export as a parameter
if [ -z "$1" ]; then
    echo "Usage : $0 jrnl_tag (without @)"
    exit -1
fi
TAG=$1

# include config
source config.sh

# Color definitions
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

INDEX_FILENAME="index$HTML_EXTENSION"
TEMPLATE=$(cat $TEMPLATE_FILE)
# make a dir to extract files
if [ ! -d "$EXPORT_DIR/$TAG" ]; then
    echo "Create $EXPORT_DIR/$TAG directory"
    mkdir $EXPORT_DIR/$TAG
fi

# extract journal entries from jrnl
echo -e "${GREEN}Extract markdown files from tag${NC} ${RED}@$TAG ${NC}"
rm -rf $EXPORT_DIR/$TAG/*$MD_EXTENSION
rm -rf $EXPORT_DIR/$TAG/*$HTML_EXTENSION
jrnl -and @$TAG --export markdown -o $EXPORT_DIR/$TAG/

# init variable to store index (blogpost list)
POSTS_LIST="<ul class='postlist'>"

# loop on all markdown files
for FILE in $EXPORT_DIR/$TAG/*.markdown
do
    echo -e "... ${RED}Processing${NC} $FILE"
    
    # remove jrnl tag in file
    sed -i -e "s/@$TAG/ /g" $FILE

    # set file name for html file
    HTML_FILENAME="${FILE/$MD_EXTENSION/$HTML_EXTENSION}"
    
    # Get title
    FIRST_LINE=$(head -n 1 $FILE)
    TITLE="${FIRST_LINE:22}" 

    # Get Date and Time
    DATE="${FIRST_LINE:4:16}"

    if [ "$USE_DATE_AS_FILENAME" = true ] ; then
        # Make HTML filename from date
        DATE_FILE="${DATE//\ /\-}"
        DATE_FILE="${DATE_FILE//\:/\-}"
        
        # HTML filename with date and hour
        HTML_FILENAME="$EXPORT_DIR/$TAG/$DATE_FILE$HTML_EXTENSION"    
    fi

    # Get HTML from Markdown
    HTML=$(sed '1d' $FILE | markdown)
    
    # substitute tags in template
    HTML_FILE="${TEMPLATE//$TITLE_TAG/$TITLE}"
    HTML_FILE="${HTML_FILE//$CONTENT_TAG/$HTML}"
    HTML_FILE="${HTML_FILE//$DATE_TAG/$DATE}"
    
    # write HTML file
    echo $HTML_FILE > $HTML_FILENAME

    # add file to the list of posts
    SIMPLE_FILENAME="${HTML_FILENAME/$EXPORT_DIR\/$TAG\//}"
    POSTS_LIST="<li><a href='$SIMPLE_FILENAME'>$TITLE</a></li>$POSTS_LIST" 

    echo -e "    HTML -> ${GREEN}$HTML_FILENAME${NC}"
done
# end list of posts
POSTS_LIST="$POSTS_LIST</ul>"

# create index file
DATE=$(date)
HTML_FILE="${TEMPLATE//$TITLE_TAG/$BLOG_NAME}"
HTML_FILE="${HTML_FILE//$CONTENT_TAG/$POSTS_LIST}"
HTML_FILE="${HTML_FILE//$DATE_TAG/$DATE}"
echo $HTML_FILE > $EXPORT_DIR/$TAG/$INDEX_FILENAME
rm -rf $EXPORT_DIR/$TAG/*$MD_EXTENSION
