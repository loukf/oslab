/*
 * mandel.c
 *
 * A program to draw the Mandelbrot Set on a 256-color xterm.
 *
 */

#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <sys/wait.h>

/*TODO header file for m(un)map*/
#include <sys/mman.h>
#include <semaphore.h>

#include "mandel-lib.h"

#define MANDEL_MAX_ITERATION 100000

/***************************
 * Compile-time parameters *
 ***************************/

/*
 * Output at the terminal is is x_chars wide by y_chars long
*/
int y_chars = 50;
int x_chars = 90;

/*
 * The part of the complex plane to be drawn:
 * upper left corner is (xmin, ymax), lower right corner is (xmax, ymin)
*/
double xmin = -1.8, xmax = 1.0;
double ymin = -1.0, ymax = 1.0;
    
/*
 * Every character in the final output is
 * xstep x ystep units wide on the complex plane.
 */
double xstep;
double ystep;

// FIX: Added the '*' to make buf a pointer rather than a plain integer
int *buf;

/*
 * Runtime global variables
 */
int t;

/*
 * This function computes a line of output
 * as an array of x_char color values.
 */
void compute_mandel_line(int line, int color_val[])
{
    /*
     * x and y traverse the complex plane.
     */
    double x, y;

    int n;
    int val;

    /* Find out the y value corresponding to this line */
    y = ymax - ystep * line;

    /* and iterate for all points on this line */
    for (x = xmin, n = 0; n < x_chars; x+= xstep, n++) {

        /* Compute the point's color value */
        val = mandel_iterations_at_point(x, y, MANDEL_MAX_ITERATION);
        if (val > 255)
            val = 255;

        /* And store it in the color_val[] array */
        val = xterm_color(val);
        color_val[n] = val;
    }
}

/*
 * This function outputs an array of x_char color values
 * to a 256-color xterm.
 */
void output_mandel_line(int fd, int color_val[])
{
    int i;
    
    char point ='@';
    char newline='\n';

    for (i = 0; i < x_chars; i++) {
        /* Set the current color, then output the point */
        set_xterm_color(fd, color_val[i]);
        if (write(fd, &point, 1) != 1) {
            perror("compute_and_output_mandel_line: write point");
            exit(1);
        }
    }

    /* Now that the line is done, output a newline character */
    if (write(fd, &newline, 1) != 1) {
        perror("compute_and_output_mandel_line: write newline");
        exit(1);
    }
}

/*
 * draw the Mandelbrot Set, one line at a time.
 * Output is sent to file descriptor '1', i.e., standard output.
 */
void compute_and_output_mandel_line(int fd, int child_num)
{
    /*
     * A temporary array, used to hold color values for the line being drawn
     */
    int color_val[x_chars];
    for (int line = child_num; line < y_chars; line += t) {
        compute_mandel_line(line, color_val);
        memcpy(&buf[line*x_chars], color_val, x_chars*sizeof(int));
        // sem_wait(&line_sems[line]);
        // output_mandel_line(fd, color_val);
        // if (line + 1 < y_chars) {
        //     sem_post(&line_sems[line + 1]);
        // }
    }
    // Shuts up the compiler warning about 'fd' being unused when the output code is commented out
    (void)fd; 
}

/*
 * Create a shared memory area, usable by all descendants of the calling
 * process.
 */
void *create_shared_memory_area(unsigned int numbytes) {
    int pages;
    void *addr;

    if (numbytes == 0) {
        fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
        exit(1);
    }

    /*
     * Determine the number of pages needed, round up the requested number of
     * pages
     */
    pages = (numbytes - 1) / sysconf(_SC_PAGE_SIZE) + 1;

    /* Create a shared, anonymous mapping for this number of pages */
    /* TODO:  
    */
    addr = mmap(NULL, pages, PROT_WRITE | PROT_READ, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    return addr;
}

void destroy_shared_memory_area(void *addr, unsigned int numbytes) {
    int pages;

    if (numbytes == 0) {
        fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
        exit(1);
    }

    /*
     * Determine the number of pages needed, round up the requested number of
     * pages
     */
    pages = (numbytes - 1) / sysconf(_SC_PAGE_SIZE) + 1;

    if (munmap(addr, pages * sysconf(_SC_PAGE_SIZE)) == -1) {
        perror("destroy_shared_memory_area: munmap failed");
        exit(1);
    }
}

int main(int argc, char *argv[])
{
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <process-count>\n", argv[0]);
        return 1;
    }
    t = atoi(argv[1]);

    xstep = (xmax - xmin) / x_chars;
    ystep = (ymax - ymin) / y_chars;

    unsigned int buf_size = (sizeof(int) * x_chars * y_chars);
    buf = create_shared_memory_area(buf_size * sysconf(_SC_PAGE_SIZE));
    for (int i = 0; i < t; ++i) {
        pid_t p = fork();
        if (p < 0) {
            perror("fork");
            _exit(1);
        } else if (p == 0) {
            compute_and_output_mandel_line(1, i);
            exit(0);
        }
    }

    for (int i = 0; i < t; ++i) {
        wait(NULL);
    }
    for (int i = 0; i < y_chars; ++i) {
        output_mandel_line(1, &buf[i*x_chars]);
    }
    destroy_shared_memory_area(buf, buf_size);

    reset_xterm_color(1);
    return 0;
}
