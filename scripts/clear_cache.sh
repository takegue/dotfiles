
# Clear PageCache, dentries and inodes
sync; echo 3 > /proc/sys/vm/drop_caches 
