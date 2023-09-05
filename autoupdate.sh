#!/bin/bash

##############################################################################
# Copyright (C) 2023 vefko and the wau tt contributors
# Take a look at the contributors.txt
#  
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#         http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################


# Define variables
clear

read -p "URL of the old Page: (eg. https://www.yoursite.yom/): " PAGEOLD
read -p "URL of the updated page (eg. https://www.yoursite.com/staging): " PAGENEW

# check if wget is aviable, on Mac it's not installed by default

if ! which wget > /dev/null; then
    echo "ERROR: wget is not installed, please install wget"
fi

# remove old logfile
if test -f "result2.log"; then
	rm result2.log
fi

if test  -f "result.log"; then
	rm result.log
fi

# Output the variables for debuging reason
echo $PAGENEW
echo $PAGEOLD

if [ ! -d "test1" ] ; then

    #Create directories for the testing
    mkdir test1 test2

    #Get the pages
    cd test1
    wget -m -E -p -e robots=off $PAGEOLD
    cd ..

    cd test2
    wget -m -E -p -e robots=off $PAGENEW
    cd ..

fi

# Crate the diff
# -q
echo "I start comparing"
#diff -q -s -r -c test1 test2 > diff.result
echo "the diff is made"

diff  -q -s -r -c test1 test2 | grep -i -w 'differ' > result.log
diff -s -r -c test1 test2 | grep -v -i -s 'wp-jason' > result2.log

# Check if there is any visible errors.
echo -e "                           WAU TT Version 0.1"
echo - "               (C) copyright 2023 by WAU tt contributors"
echo -e "                        under Apache License 2.0"
if [ ! -s "result.log" ]; then
    echo -e "\n\n||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    echo         "|||                The Site is fine!!!                   |||"
    echo -e      "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n\n"
else
    echo -e "\n\n||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    echo         "|||                   Site is not ok!!                   |||"
    echo -e      "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n\n"
    echo "Here is the log output"
    sleep 5
    cut result2.log
fi

read -p "delete the files y/n:" DELETE


#delete directories for testing

if [  $DELETE == "y" ] ; then

    rm -r test1 test2
fi

