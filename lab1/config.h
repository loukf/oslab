#pragma once

#define CHUNK 1024

#define MAX_CHUNKS 1024

#define MAX_WORKERS 256

#define LOOP_WAIT 100*1000

#define WORK_WAIT 1000*1000

const char *HELP_MSG =
"Available commands:\n"
"   add <x>\tadd x workers (search processes)\n"
"   sub <x>\tremove x workers\n"
"   info\t\tdisplay information about active workers\n"
"   prog\t\tshow current search progress\n"
"   help\t\tdisplay this help message\n"
"   exit\t\texit the program\n";
