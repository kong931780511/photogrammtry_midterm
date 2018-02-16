# Estimating Dichromatic Reflection Model From Images 
## (A)Brief Description of Algorithm
In my program, I mainly utilized the `VLFeat` to get the superpixel segmentation pictures of my data. After I got segementation pictures, I utilized `GPhotometricauss-Seidel iterations` to get a relatively accurate result of color estimation.
>>>>>>The formulu which I used was shown as following:
![](https://github.com/kong931780511/photogrammtry_midterm/blob/master/form.jpg)
## (B)About Program
My program mainly has two part: `superpixel segementation` & `Gauss-Seidel iterations`
In my `main` function, I first included the path of `VLFeat` which I utilized to get superpixel


