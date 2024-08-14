#!/usr/local/bin/python3
import requests
import concurrent.futures
from tqdm import tqdm
from collections import defaultdict
import argparse

lengths = []
lengths_dict = defaultdict(list)

def main():
    parser = argparse.ArgumentParser(description='Ping URLs with parameters')
    parser.add_argument('base_url', help='Base URL to ping')
    parser.add_argument('name', help='Parameter name')
    parser.add_argument('values', nargs='+', help='Parameter values or range specification (e.g., "1-100")')
    parser.add_argument('-v', '--verbose', action='store_true', help='Verbose output')
    parser.add_argument('-t', '--threads', type=int, default=16, help='Max number of threads')
    parser.add_argument('-T', '--timeout', type=int, default=8, help='Ping timeout')
    parser.add_argument('-R', '--rawvalues', action='store_true', help='Raw output for values (default is a range)')
    args = parser.parse_args()

    base_url = args.base_url
    name = args.name
    values = args.values
    if '-' in values[0]:
        start, end = map(int, values[0].split('-'))
        values = range(start, end + 1)
    else:
        values = list(map(int, values))
    verbose = args.verbose
    maxthreads = args.threads
    timeout = args.timeout
    rawvalues = args.rawvalues

    try:
        pingiter(base_url, name, values, verbose=verbose, maxthreads=maxthreads, timeout=timeout)
    except KeyboardInterrupt:
        print("Received SIGINT, terminating...")

    if rawvalues == True:
        print("Lengths and corresponding values:")
        for length, values in lengths_dict.items():
            print(f"Length {length}: {', '.join(map(str, values))}")
    else:
        print("Lengths and corresponding value ranges:")
        for length, value_list in lengths_dict.items():
            min_value = min(value_list)
            max_value = max(value_list)
            if min_value == max_value:
                print(f"Length {length}: {min_value}")
            else:
                print(f"Length {length}: {min_value}-{max_value}")

def pinglen(url, timeout):
    try:
        response = requests.get(url, timeout=timeout)
        response.raise_for_status()
        return len(response.content)
    except requests.RequestException as e:
        print(f'ERRO: {e}')
        return None

def paramurl(baseurl, name, value):
    return f'{baseurl}?{name}={value}'

def pinglenparam(baseurl, name, value, verbose, timeout):
    url = paramurl(baseurl, name, value)
    len = pinglen(url, timeout)
    if len is not None:
        lengths_dict[len].append(value)
        if verbose:
            print(f'{value:<8}{len:<8}')

def pingiter(baseurl, name, values, *, verbose=False, maxthreads, timeout):
    """
    Ping all values and get return length (size)
    """
    with concurrent.futures.ThreadPoolExecutor(max_workers=maxthreads) as executor:
        futures = [executor.submit(pinglenparam, baseurl, name, value, verbose, timeout) for value in values]
        try:
            for future in tqdm(concurrent.futures.as_completed(futures), total=len(values), desc="Making requests"):
                future.result()
        except KeyboardInterrupt:
            print("Received SIGINT, terminating...")
            for future in futures:
                future.cancel()

main()

