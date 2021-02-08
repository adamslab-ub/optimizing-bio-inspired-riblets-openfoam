#!/bin/bash
for file in $(cat $1); do tar -czvf $file".tar.gz" $file; done
