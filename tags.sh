find -iname "*.java" > ./cscope.files
find -iname "*.xml" >> ./cscope.files
#find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files

ctags --fields=+i -n -R -L ./cscope.files

cscope -bkq -i ./cscope.files
