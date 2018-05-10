# curlbench

CURL BENCHMARK TEST For Swift 4.1.1

## Download

```
git clone https://github.com/RockfordWei/curlbench.git 
```

## Build & Run

```
time swift run curlbench [loops]
```

The `loops` determines how many curls should perform in this session. 10 by default. 

**NOTE** 100 loops should be finished in 2 minutes as a common sense.

## System Usage Observation

you can try `time swift run curlbench 100 &` then immediately go with a bash command `top` to see if the curl is using too many system resources.