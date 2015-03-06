#find /home/qiufuqing/framework/1410W_EX/frameworks/base/core -iname "*.java" -o -name "*.xml" -o -name "*.h"  -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" > ./cscope.files

find /home/qiufuqing/framework/1420F_EX/LNX.LA.3.7.2-01110-8x16.0/frameworks -iname "*.java" -o -name "*.xml" -o -name "*.h"  -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" > ./cscope.files

#find -iname "*.xml" >> ./cscope.files
#find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" > cscope.files

ctags --fields=+i -n -R -L ./cscope.files

cscope -bkq -i ./cscope.files
