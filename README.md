## Requirements

* ruby 2.x
* bundler

## Usage

1) Install dependencies using `bundle`

2) A command-line tool is available at `bin/commander`. Example usage:

```
cat <<EOF | bin/commander
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
EOF
```

3) Execute tests running `bundle exec rspec`

## Notes

The application now checks plateau boundaries and occupied positions and ignores invalid instructions.
