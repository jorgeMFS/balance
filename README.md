<p align="center">
<img src="icons/logo.pdf" alt="Balance" width="50" border="0" /></p>
<br>
<p align="center">
Benchmark in ALgorithmic And Natural data ComprEssion
</p>

## INSTALL
Get **BALANCE** project using:

```
bash
git https://github.com/jorgeMFS/balance.git
cd balance/
```

## Images

The /Images folder contains 5 subfolders each with 9 images of a Specific Category:

* CA_IMG : Binary cellular automaton arrays created by the python script in **/CA_Creator** folder.

* CR_IMG : Computed Radiography Images obtained from the [NHI repository](https://www.kaggle.com/nih-chest-xrays/data)

* DR_IMG : Diabetic Retinopathy Images from the [Kaggle Diabetic Retinopathy Detection Challenge](https://www.kaggle.com/c/diabetic-retinopathy-detection)

* NA_IMG : Natural Images Obtained from [Microsoft COCO Dataset](http://cocodataset.org/#download)

* US_IMG:Ultrasound Images from a private dataset.

## Results
To see the results of the Benchmark of the images go to the **Results/** folder.
```
/Results
```
## RUN
To replicate results folder use **run.sh**:

```
chmod +x run.sh
bash run.sh
```

To create a graph of Compression of a given image, move to the **src/** directory and run **run_image.sh**:

```
cd src/
chmod +x run_images.sh
bash run_images.sh Complete/Path/of/the/Image
```

## CA Creation

If you wish to create other Binary cellular automaton arrays or images you may do so by using the file **ca.py** in the **CA_Creator/** folder.
Requirments:

- Python 3.6
- Numpy
- matplotlib
- PIL

## Warnings:
Although it is possible to run this program with CMIX, by changing the variable USECMIX on **src/Compressors.sh** and on **src/run_images**, this action is not recommended unless you have enough computational resources.
