Let’s suppose we record two or more signals obtained from two or more independent speech sources and we mix them. After that we try to perform blind source separation using FastICA to extract two or more source signals from the mixture.

In our case we used three signals, mixed them using different mixing coefficients and extracted the source signals using the FastICA implementation as described in the following pages.

In our implementation we have the following signals:
• src1.wav: Ellen Degeneres speech
• src2.wav: Mark Zuckerberg speech
• src3.wav: Anne Hathaway speech

In the next chapter we are going to have a look at the actual implementation details explained in a mathematical notation, as well as look at the source code built using Matlab.

