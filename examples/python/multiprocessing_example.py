import multiprocessing as mp


def example_process(process_id):
    print(f"process id: {process_id}")


def multiprocessing_queue():
    breakfast = [
        "spam",
        "eggs",
        "ham",
    ]
    queue = mp.Queue()
    print("queuing items...")
    for index, food in enumerate(breakfast):
        print(f"item # {index+1}: {food}")
        queue.put(food)
    print("emptying queue...")
    count = 0
    while not queue.empty():
        count += 1
        print(f"item # {count} {queue.get()}")


def multiprocessing_basics():
    cpu_count = mp.cpu_count()
    print(f"CPU count: {cpu_count}")
    print("starting processes")
    procs = []
    for i in range(cpu_count):
        proc = mp.Process(target=example_process, args=(i,))
        procs.append(proc)
        proc.start()
    for proc in procs:
        proc.join()


def main():
    multiprocessing_basics()
    multiprocessing_queue()


if __name__ == "__main__":
    main()
