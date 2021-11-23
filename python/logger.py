"""Example initiation of logging module
Handy for translating CLI verbosity args (which typically expect lower values for less
verbosity) to the logging module verbosity levels (which expect higher values for less
verbosity).
"""
import logging

def configure_logger(verbosity, log_file=None):
    """Translate the verbosity from the command line (higher value == more verbose)
    to the logging module's verbosity (higher value == less verbose) and
    configure the logging module.
    """
    try:
        assert 1 <= int(verbosity) <= 5
        levels = range(7)
        levels.reverse()
        ytisobrev = levels[int(verbosity)]
        verbosity = getattr(logging, logging.getLevelName(ytisobrev*10), logging.ERROR)
    except (TypeError,ValueError):
        verbosity = getattr(logging, verbosity.upper())
    except AssertionError:
        msg = "Invalid verbosity level: {} valid levels are 1-5".format(verbosity)
        raise ValueError(msg)
    format_str = "%(levelname)s [%(asctime)s][%(threadName)s] - %(message)s"
    logging.basicConfig(
            level=verbosity,
            filename=log_file,
            filemode='a',
            format=format_str,
            )

def display_example_messages():
    logging.critical('this is a critical log message')
    logging.error('this is an error log message')
    logging.warning('this is a warning log message')
    logging.info('this is an info log message')
    logging.debug('this is a debug log message')
    print(('Note that log messages are on STDOUT '
          'while print statements are on STDIN'))

def parse_args():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument(
            '-v',
            '--verbosity',
            default=3,
            help="verbosity level (1-5, critical, error, warning, info, debug)",
            )
    parser.add_argument(
            '-f',
            '--logfile',
            default=None,
            help="optional file to log the messages instead of displaying them.",
            )
    return parser.parse_args()

def main():
    """Display the chosen verbosity level and print examples of the selected verbosity messages.
    """
    args = parse_args()
    configure_logger(args.verbosity, args.logfile)
    display_example_messages()



if __name__ == '__main__':
    main()
