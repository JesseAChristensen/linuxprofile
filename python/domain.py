import socket

def resolve_hostname(name):
    """resolve hostname to IP or returns IP if name is already an IP
        Raises: socket.gaierror if the hostname can't be resolved
    """
    try:
        socket.inet_aton(name)
        return name
    except socket.error:
        return socket.gethostbyname(name)

def main():
    hostnames = [
            'localhost',
            '127.0.0.1',
            'testdomain.imsar.us',
            'testdomain',
            'mcast',
            'google.com',
            ]
    for name in hostnames:
        print(name, resolve_hostname(name))

if __name__ == '__main__':
    main()
