#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <syslog.h>
#include <time.h>


int main(int argc, char **argv) 
{
    setlogmask (LOG_UPTO (LOG_INFO));
    openlog("resmond", LOG_PID | LOG_NDELAY, LOG_DAEMON); // Open the syslog with the daemon name and log options

    time_t raw_time;
    struct tm *timeinfo;

    while (1) 
    {
        // Main functionality
        time(&raw_time);
        timeinfo = localtime(&raw_time);
        syslog(LOG_INFO, "Current time is: %s", asctime(timeinfo));

        // Sleep for a while to avoid high CPU usage
        sleep(2);
    }

    closelog();  // Close the syslog before exiting
    return EXIT_SUCCESS;
}
