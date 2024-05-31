import sys

import app


def main():
    args_in = sys.argv[1:]

    if len(args_in) == 0:
        print("Please enter at least one integer")
        return None

    try:
        args = [int(x) for x in args_in]
    except ValueError:
        print("Please enter a valid list of integers")
        return None

    print(app.addition(*args))


if __name__ == "__main__":
    main()
