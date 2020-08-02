# DWM

Keywords:

> DWM,	Digital Watermarking, Digital Watermark

> DWT,	Discrete Wavelet Transform

> DCT,	Discrete Cosine Transform

> Image processing

Digital Watermarking (DWM) is a technique of protecting digital data. 
This code base implements 2 methods for marking digital images based on DCT and DWT. 
Several attacks (signal degradations such as noise, dithering, filtering, cropping) on marked image were conducted. 
Attacked images are saved and the watermark is extracted. 
Robustness of DWT vs DCT is graded based on the quality of extracted watermark. 
The measure used is the coefficient of correlation (0-100%). 

References:

https://www.researchgate.net/publication/343385316_Digital_Watermarking_-_Comparison_of_DCT_and_DWT_methods

https://www.researchgate.net/publication/343385676_Digital_Watermarking_in_Wavelet_domain_-_Comparison_of_different_types_of_wavelets
