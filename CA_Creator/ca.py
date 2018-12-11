import  numpy as np 
import matplotlib.pyplot as plt
from PIL import Image

def ca(rule:int,MtxSize:list=[256,256]) -> np.ndarray:
    CombMtx=[8,3]
    output_pattern = [int(x) for x in np.binary_repr(rule, width=8)]
    input_pattern = np.zeros(CombMtx)
    for ii in range(CombMtx[0]):
        input_pattern[ii,:]=[int(x) for x in np.binary_repr(7-ii,width=CombMtx[1])]
    
    canvas = np.zeros(MtxSize)

    nbRows=np.shape(canvas)[0]
    nbCls=np.shape(canvas)[1]
    columns=nbCls-2
    rows=(np.shape(canvas)[1]-2)

    canvas[0,(columns//2)+1] =1

    for ii in np.arange(0, rows-1):
        for jj in np.arange(0,columns):
           for kk in range(8):
               if np.array_equal(input_pattern[kk,:], canvas[ii,jj:jj+3]):
                   canvas[ii+1,jj+1]=output_pattern[kk]
    canvas=np.invert(canvas.astype(bool)).astype(int)
    #print(np.shape(canvas))
    return canvas

def save_ca_asimage(imarray:np.ndarray,path:str,name:str):
    imarray = imarray.tolist()
    X = np.array(imarray)
    img = Image.new('1', (256,256))
    pixels = img.load()
    for i in range(img.size[0]):
        for j in range(img.size[1]):
            pixels[j, i] = imarray[i][j]
    savepath = path + name + '.png'
    img.save(savepath)
    
def save_as_txt(imarray:np.ndarray,path:str,name:str):
    savepath = path + name + '.bin'
    np.savetxt(fname=savepath,X=imarray,fmt='%i',delimiter="")



if __name__ == "__main__":
    Rule =[73,86,89,109,193,135,149,161,182]
    MtxSz = [512,512]
    Plot=False      
    svpth='../Images/CA_img/'

    for x in Rule:
        canvas = ca(rule=x,MtxSize=MtxSz)
        save_as_txt(imarray=canvas,path=svpth,name=str(x))
        
        if Plot:
            fig=plt.figure()
            plt.imshow(canvas, cmap=plt.get_cmap('gray'), vmin=0, vmax=1)
            plt.show()


     

    

