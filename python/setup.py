from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize
import numpy as np
from os.path import join, sep
from glob import glob


incl_dirs = ['.', 'include', 'include/CameraModels', np.get_include(), '/usr/local/include/opencv2', '/usr/local/include/eigen3', '/usr/include/GL']

opencv_lib_dir = '/usr/local/lib'
lib_dirs = ['lib', opencv_lib_dir, '/usr/lib/x86_64-linux-gnu']

libs = set([])
for file in glob(join(opencv_lib_dir, 'libopencv_*')):
    libs.add(file.split('.')[0])
libs = [lib.split(sep)[-1][3:] for lib in libs]

libs.append('GLEW')
libs.append('pangolin')
libs.append('ORB_SLAM3')

setup(
    cmdclass={'build_ext': build_ext},
    ext_modules=cythonize(Extension(
        "orbslam3",
        sources=["python/orbslam3.pyx"],
        language="c++",
        include_dirs=incl_dirs,
        library_dirs=lib_dirs,
        libraries=libs
    ), build_dir="build")
)
