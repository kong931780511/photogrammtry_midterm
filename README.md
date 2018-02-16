# Estimating Dichromatic Reflection Model From Images 
## (A)Brief Description of Algorithm
As shown below, the reflection of light can be considered to be a combination of diffuse and specular reflections:
![](https://github.com/kong931780511/photogrammtry_midterm/blob/master/pic.jpg)
In Dichromatic Reflection Model, incident light reflected from an object is written as a linear combination of diffuse and specular reflections:
![](https://github.com/kong931780511/photogrammtry_midterm/blob/master/model_form.png)
There are many ways to compute them, I choose `Gauss-Seidel iterations` to get an estimation of the reflection.
In my program, I mainly utilized the `VLFeat` to get the superpixel segmentation pictures of my data. After I got segementation pictures, I utilized `Gauss-Seidel iterations` to get a relatively accurate result of color estimation.
>>>>>>The formulu which I used was shown as following:
![](https://github.com/kong931780511/photogrammtry_midterm/blob/master/form.jpg)
## (B)About Program
>* My program mainly has two part: `superpixel segementation` & `Gauss-Seidel iterations`
>* In my `main` function, I first included the path of `VLFeat` which I utilized to get superpixel and do segmentation
>* Then a function named `GS_iter` was called. Its main idea is to conducted `Gauss-Seidel iterations` on the segmentation results to get relatively accurate value of `md` `cd` `ms` `cs` (which 'd' means 'diffuse' and 's' means 'specular'). During this process two function were also called: `cal_m` & `cal_c` which were used to calculate the color value and its coefficient.
>* Finally, in order to get the final result of true color picture, I used each channel of `cd` multiply with `md`
## (C)Result
### "Duck" 
the picture is listed as following order: 
#### `original` + `final_result` -> `original_superpixel_segmentation` + `changed_superpixel_segmentation` -> `md` + `ms`
<img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/6.png" width="50%" height="50%"><img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/6_result.png" width="50%" height="50%">
<img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/6_ori_sup.png" width="50%" height="50%"><img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/6_change_sup.png" width="50%" height="50%">
<img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/6_md.png" width="50%" height="50%"><img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/6_ms.png" width="50%" height="50%">
>>We can see from the `result` and `original_superpixel_segmentation` that there still exists some segementation mistakes (The head of duck should be a complete part, but in `original_superpixel_segmentation` the color was divided into different parts). Besides, the eye's color is also wrong in the `result`.
So I changed the iteration times from 3 to 10, then I got a relatively worse result:
<img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/test_duck_c.jpg" width="50%" height="50%"><img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/duck/test_duck.jpg" width="50%" height="50%">
Compared with `result` shown above, we can see the eye's color even become as same as its head.
### "RPAC basketball playground"
Although there exists some shortcomings in my outcome, I also get some good results:
<img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/basketball_floor/test5.jpg" width="50%" height="50%"><img src="https://github.com/kong931780511/photogrammtry_midterm/blob/master/data/basketball_floor/5_result.png" width="50%" height="50%">
As the result shows, the color of floor after optimization is better compared with original pictures.

                                  
                                                                                                    kong.325
