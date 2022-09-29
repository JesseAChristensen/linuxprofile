"""Examples of the following python skills:
    * __eq__ method to compare objects
    * getattr() function usage
    * simple class inheritance
"""

class TestClass():
    def __init__(self, name='spam'):
        self.name = name
        self.icon = 'eggs'
        self.locationInDirectory = 'ham'

    def __eq__(self, other):
        if not isinstance(other, TestClass):
            return False
        interesting_attrs = [
                'name',
                'icon',
                'locationInDirectory',
                ]
        return all([
            getattr(other, i) == getattr(self, i)
            for i in interesting_attrs
            ])

class Example(TestClass):
    def __init__(self):
        self.name = 'spam'
        self.icon = 'eggs'
        self.locationInDirectory = 'ham'

def main():
    print('this should be true: ', TestClass() == Example()) #true
    print('this should be false: ', TestClass('foo') == Example()) #false


if __name__ == '__main__':
    main()
