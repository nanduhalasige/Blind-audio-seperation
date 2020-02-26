### Separation of Independent Audio Source from Mixture


Let’s suppose we record two or more signals obtained from two or more independent speech sources and we mix them. After that we try to perform blind source separation using FastICA to extract two or more source signals from the mixture.

In our case we used three signals, mixed them using different mixing coefficients and extracted the source signals using the FastICA implementation as described in the following pages.

In our implementation we have the following signals:<br>
* src1.wav: Ellen Degeneres speech <br>
* src2.wav: Mark Zuckerberg speech <br>
* src3.wav: Anne Hathaway speech 

<p>
<strong> What is FastICA? </strong> 
FastICA is an algorithm used for independent component analysis (ICA). It is a really
efficient and simple algorithm used a lot for blind source separation problems (BSS). In
our case we are using FastICA to separate a set of source signals from a mixed signal
with the need of very little information about the source and the process used to mix the
sources. The source signals in our case are audio signals in a wav format.
</p>

![flowchart](https://github.com/nanduhalasige/Blind-audio-seperation/blob/master/Flowchart.PNG)

## Result
![result](https://github.com/nanduhalasige/Blind-audio-seperation/blob/master/Result.PNG)

