#include <unistd.h>
#include "utils.h"

ssize_t safe_write(const int fdr, const void *buff, const size_t len) {
    ssize_t total_written = 0;
    char *ptr = (char *)buff;
    while (total_written < len) {
        ssize_t bytes_written = write(fdr, ptr + total_written, len - total_written);
        if (bytes_written > 0) {
            total_written += bytes_written;
        } 
        else if (bytes_written == 0) {
            break;
        } 
        else {
            return (total_written > 0) ? total_written : -1;
        }
    }
    return total_written;
}


ssize_t safe_read(const int fdr, const void *buff, const size_t len) {
    ssize_t total_read = 0;
    char *ptr = (char *)buff;
    while (total_read < len) {
        ssize_t bytes_read = read(fdr, ptr + total_read, len - total_read);
        if (bytes_read > 0) {
            total_read += bytes_read;
        } 
        else if (bytes_read == 0) {
            break;
        } else {
            return (total_read > 0) ? total_read : -1;
        }
    }
    return total_read;
}

ssize_t safe_pread(const int fdr, const void *buff, const size_t len, off_t offset) {
    ssize_t total_read = 0;
    char *ptr = (char *)buff;
    while (total_read < len) {
        ssize_t bytes_read = pread(fdr, ptr + total_read, len - total_read, offset + total_read);
        if (bytes_read > 0) {
            total_read += bytes_read;
        } 
        else if (bytes_read == 0) {
            break;
        } 
        else {
            return (total_read > 0) ? total_read : -1;
        }
    }
    return total_read;
}
