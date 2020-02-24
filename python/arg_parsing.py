from pathlib import Path

def parse_args():
    import argparse #perfectly acceptable to do the import in the function
    description = 'example description'
    parser = argparse.ArgumentParser(description)
    parser.add_argument('-s', '--string', dest='string', type=str, help='arg takes a string', required=True)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('-f', '--flag', dest='do_flag', action='store_true', help='do flag')
    group.add_argument('-g', dest='do_gag', action='store_true')
    parser.add_argument('--print-this', type=str, help='string to print')
    parser.add_argument('--input_file', type=argparse.FileType('rb', 0), help='input file to read') #understands "-" as stdin
    parser.add_argument('--output_file', type=argparse.FileType('rb', 'UTF-8'), help='file to output') #understands "-" as stout
    parser.add_argument('--choice', choices=['apple', 'orange', 'banana'])
    #parser.add_argument('others', nargs='?') #consumes 1 (optional) positional argument
    #parser.add_argument('others', nargs='+') #consumes all positional arguments (err if no args)
    #parser.add_argument('others', nargs=2) #expects 2 positional arguments
    parser.add_argument('others', nargs='*') #expects any number of positional arguments
    parser.epilog('message displayed at the end of the help message')
    args = parser.parse_args()
    return args

def main():
    args = parse_args()
    for name,arg in args._get_kwargs():
        print(name, arg)
    if args.do_flag:
        print('doing flag')
    if args.do_gag:
        print('doing gag')
    if args.print_this:
        print(f'printing this: {args.print_this}')
    print(f'string argument: {args.string}')
    for each in args.others:
        print(f'optional arg: {each}')
    if args.choice:
        print(f'choice was: {args.choice}')
    if args.input_file:
        print(f'file name: {args.input_file.name}')
        print(Path(args.input_file.name).resolve())
        print(args.input_file.read())


if __name__ == '__main__':
    main()
