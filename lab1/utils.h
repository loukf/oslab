#pragma once

ssize_t safe_write(const int fdr, const char *s, const size_t len);

ssize_t safe_read(const int fdr, char *s, const size_t len);

ssize_t safe_pread(const int fdr, char *s, const size_t len, off_t offset);
