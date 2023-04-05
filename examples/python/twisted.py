"""
Example implementation(s) of twisted servers and clients
"""
from twisted.internet import reactor
from twisted.internet.protocol import Protocol,Factory
#from twisted.internet.protocol import ClientFactory,ReconnectingClientFactory

class EchoProtocol(Protocol):
    def dataReceived(self, data):
        """
        every time data is received, we write that data back to the socket
        """
        self.transport.write(data)

    def connectionMade(self):
        # every time a connection is made, we send back "foo" and call loseConnection
        self.transport.write('foo')
        self.transport.loseConnection()

    def logPrefix(self):
        return 'echo-protocol'



class Echo(Factory):
    def buildProtocol(self, addr):
        return EchoProtocol()


def main():
    factory = Echo()
    reactor.listenUNIX(
        '/home/user/test.sock',
        factory,
        )
    reactor.run()


if __name__ == '__main__':
    main()
