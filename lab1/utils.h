#pragma once

ssize_t safe_write(const int fd, const void *buff, const size_t len);

ssize_t safe_read(const int fd, const void *buff, const size_t len);

ssize_t safe_pread(const int fd, const void *buff, const size_t len, off_t offset);
