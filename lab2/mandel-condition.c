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
#include <pthread.h>
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

// sem_t *line_sems;

/*
 * Runtime global variables
 */
int t;
int next_line = 0;

pthread_mutex_t print_lock = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t print_cond = PTHREAD_COND_INITIALIZER;

/*
 * This function computes a line of output
 * as an array of x_char color values.
 */

void compute_mandel_line(int line, int color_val[]) {
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
void output_mandel_line(int fd, int color_val[]) {
	int i;
	
	char point ='@';
	char newline='\n';

	for (i = 0; i < x_chars; ++i) {
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
void *compute_and_output_mandel_line(void *thread_id) {
    int color_val[x_chars];
    for (int line = (int)(long)thread_id; line < y_chars; line += t) {
        compute_mandel_line(line, color_val);
        pthread_mutex_lock(&print_lock);
        while (line != next_line) {
            pthread_cond_wait(&print_cond, &print_lock);
        }
        output_mandel_line(1, color_val);
        next_line++;
        pthread_cond_broadcast(&print_cond);
        pthread_mutex_unlock(&print_lock);
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <thread-count>\n", argv[0]);
        return 1;
    }
    t = atoi(argv[1]);
    pthread_t threads[t];

	xstep = (xmax - xmin) / x_chars;
	ystep = (ymax - ymin) / y_chars;

    for (int i = 0; i < t; ++i) {
        pthread_create(&threads[i], NULL, compute_and_output_mandel_line, (void*)i);
    }

    for (int i = 0; i < t; ++i) {
        pthread_join(threads[i], NULL);
    }

    pthread_mutex_destroy(&print_lock);
    pthread_cond_destroy(&print_cond);

    reset_xterm_color(1);
    return 0;
}
