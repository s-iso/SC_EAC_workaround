# SC_EAC_workaround
workaround for the EAC bug on linux

## What is the "SC EAC bug on linux"?
CIG implemented EAC for Star Citizen. During their implementation, based on all observations made by @ZeroNationality in the LUG discord and myself, they seemed to have made a faulty implementation on startup. To explain it in Pseudocode:
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

That means that the Linux version is **only allowed to start** the game if EAC checks **failed**. Meaning that we had to deliberately made the checks fail in order to play the game.

This loophole has then been fixed by CIG adding another EAC check when the player tries to enter the Public Universe, although this check was working the right way around for some unexplainable reason.

That's why we let the initial EAC check fail on purpose by choking out it's connection to the server with a "hosts fix", just to then open it up again to allow it to do another EAC check later on that works properly.

This loophole has then been fixed by the servers not allowing EAC to do a proper full check again in the menus. Meaning that EAC will only report the initial (deliberately faulty) state, without checking again later on. This means that, at this point, we're either able to enter the main menu by chocking the response, but won't be able to connect to the servers, or we're unable to start the game due to the bug in CIGs code, but would in theory be able to join the servers afterwards.

The only way to fix this is by asking CIG to fix their initial loading bug. This repository serves a proof of work for anyone to test for themselves that they're able to enter the game by deliberately breaking EAC, and for documentation purposes.

On top of that, there's obviously still hope that someone might come up with a different workaround based on the work I've already done, in case CIG does once again not listen to our issues of us being unable to enter the game. Given that they've been actively watching my progress step by step, I'm starting to believe that they will likely also close any further loophole we'll find, so keep your enthusiasm low if you're willing to spend time and effort into finding another workaround.

## Usage
Download the .sh file, place it anywhere on your PC, run it without sudo. Instructions are in there.
**Be aware, the workaround is currently only getting you into the main menu and won't allow you to play the game. It is safe to use as it has an insane amount of checks in it, but I am not responsible for you potentially getting banned using it.**

## License
Do whatever with this, share it, print it, use it as toilet paper. I do not take any responsibility for any usage of this, as is clearly stated in the first line of code.
