# SC_EAC_workaround
workaround for the EAC bug on linux

## What is the "SC EAC bug on linux"?
CIG implemented EAC for Star Citizen. During their implementation, based on all observations made my @ZeroNationality in the LUG discord and me, they seemed to have made a faulty implementation on startup. To explain it in Pseudocode:
```
if (windows) {
    if (EACisWorkingCorrectly) {
       everythingIsAwesome();
    } else {
       displayError0();
    }
} else if (linux) {
    if (!EACisWorkingCorrectly()) {
       everythingIsAwesome();
    } else {
       displayError0();
    }
}
```

In previous days of glory, the EAC implementation has did another check later on, and was working perfectly fine at that point, hence I created this script. In the current iteration, this does not seem to be the case. EAC only checks once on startup, does not check again, and stays opinionated on the faulty check. This workaround script is therefore not working anymore unless we find a different way, but it seems impossible.

## Usage
Download the .sh file, place it anywhere on your PC, run it without sudo. Instructions are in there.
**Be aware, the workaround is currently not working!**

## License
Do whatever with this, share it, print it, use it as toilet paper. I do not take any responsibility for any usage of this, as is clearly stated in the first line of code.
