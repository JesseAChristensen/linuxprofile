"""I rarely use ctypes and numpy, but when I do I always forget how they compare to eachother
"""
import ctypes as ct
import numpy as np
from pprint import pprint

def ctype_to_numpy():
    c_types = [
            ct.c_bool,
            ct.c_char,
            ct.c_wchar,
            ct.c_byte,
            ct.c_ubyte,
            ct.c_short,
            ct.c_ushort,
            ct.c_int,
            ct.c_uint,
            ct.c_long,
            ct.c_ulong,
            ct.c_longlong,
            ct.c_ulonglong,
            ct.c_size_t,
            ct.c_ssize_t,
            ct.c_float,
            ct.c_double,
            ct.c_longdouble,
            ct.c_char_p,
            ct.c_wchar_p,
            ct.c_void_p,
            ]
    np_translation = {}
    for each_ctype in c_types:
        try:
            np_translation[np.dtype(each_ctype).str] = each_ctype
        except TypeError:
            print('type error: ', each_ctype)
    return np_translation
    return {np.dtype(ctype).str: ctype for ctype in c_types}

def main():
    pprint(ctype_to_numpy())


if __name__ == '__main__':
    main()
