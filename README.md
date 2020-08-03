# DWM [![View Digital Watermarking – Comparison of DCT and DWT methods on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/78790-digital-watermarking-comparison-of-dct-and-dwt-methods) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com//etfovac/watermark/master/LICENSE.md) [![GitHub (pre-)release](https://img.shields.io/badge/release-1.0.1-yellow.svg)](https://github.com/etfovac/watermark/releases/tag/1.0.1)

### Keywords:

> DWM,	Digital Watermarking, Digital Watermark

> DWT,	Discrete Wavelet Transform

> DCT,	Discrete Cosine Transform

> Digital Image processing


## Basic Overview
Digital Watermarking (DWM) is a technique of protecting digital data.  
This code base implements 2 methods for marking digital images based on DCT and DWT.  
Several attacks (signal degradations such as noise, dithering, filtering, cropping, lossy JPEG compression) on a marked image were conducted.  
Attacked/degraded images are saved and the watermark is extracted.  
Robustness of DWT vs DCT is graded based on the quality of extracted watermark.  
The measure used is the Correlation coefficient (0-100% or 0-1).  

![Basic Overview](https://github.com/etfovac/watermark/blob/master/2020-08-02_230949.png)

## References:  
<a href="https://www.researchgate.net/profile/Nikola_Jovanovic9">Nikola Jovanovic on ResearchGate</a>  
<a href="https://www.researchgate.net/publication/343385316_Digital_Watermarking_-_Comparison_of_DCT_and_DWT_methods">Digital Watermarking – Comparison of DCT and DWT methods, ResearchGate</a>  
<a href="https://www.researchgate.net/publication/343385676_Digital_Watermarking_in_Wavelet_domain_-_Comparison_of_different_types_of_wavelets">Digital Watermarking in Wavelet domain – Comparison of different types of wavelets, ResearchGate</a>

## Download
Download the latest [release here][0].

[0]: https://github.com/etfovac/watermark/releases
