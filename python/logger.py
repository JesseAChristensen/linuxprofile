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

