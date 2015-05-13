CURRENT_PATH=`pwd`
find $CURRENT_PATH -iname "*.java" -o -name "*.xml" -o -name "*.h"  -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" > ./cscope.files

#find -iname "*.xml" >> ./cscope.files
#find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" > cscope.files

ctags --fields=+i -n -R -L ./cscope.files

cscope -bkq -i ./cscope.files
