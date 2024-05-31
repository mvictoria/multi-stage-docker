import sys

import app


def main():
    args = [int(x) for x in sys.argv[1:]]
    print(app.addition(*args))


if __name__ == "__main__":
    main()
