import subprocess

def do_command(cmd, cwd=None):
    """Run a command in the shell
    args:
        *cmd: str, command to run in the shell
        *error_okay: bool, if True, ignore errors
        *debug: bool, if True, show the cmd as it is run in the shell
    """
    cwd = cwd if cwd else os.getcwd()
    cmd_stream = subprocess.Popen(
            cmd,
            cwd=cwd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            shell=True,
            )
    std_out, std_err = cmd_stream.communicate()
    return std_out.decode('utf-8'), std_err.decode('utf-8'), cmd_result

