import sys

import app


def main():
    args_in = sys.argv[1:]

    if len(args_in) == 0:
        print("Please enter at least one integer")
        sys.exit(1)

    try:
        args = [int(x) for x in args_in]
    except ValueError:
        print("Please enter a valid list of integers")
        sys.exit(1)

    print(app.addition(*args))
    sys.exit(0)


if __name__ == "__main__":
    main()
