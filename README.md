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

## Caveats

It was not specified what happens when a rover is instructed to move beyond the plateau bounds. The actual implementation does not handle out of bound cases, and the plateau bounds are unused.
This also makes the initialization command redundant.

In the case plateau bounds are considered important, two possible solutions could be implemented:

* Ignore calls to Rover#advance! that would make it fall under/over the plateau bounds ({x: 0...width, y: 0...height})
* Throw an error and exit the program

## Notes

As you will probably notice, I rebased the complete history. I like my commits to be atomic, I commit locally very often but I always squash redundant commits before pushing to avoid noise.
