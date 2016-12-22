# Some configuration ----------------
# You should modify these
BLOG_NAME="My Journal"
TEMPLATE_FILE="templates/template.html"
MD_EXTENSION=".markdown"
HTML_EXTENSION=".html"
TITLE_TAG="!TITLE!"
DATE_TAG="!DATE!"
CONTENT_TAG="!CONTENT!"
USE_DATE_AS_FILENAME=true
EXPORT_DIR="export" # without "/" at the end
HOMEPAGE_TEXT="<p>My journal is about...</p>"
# END of configuration --------------


# TAG specific configuration --------
# you can add tag specific config
if [ "$TAG" = "work" ] ; then
    BLOG_NAME="Hello world !"
    TEMPLATE_FILE="templates/pure.html"
    USE_DATE_AS_FILENAME=false
fi
# END of configuration---------------
